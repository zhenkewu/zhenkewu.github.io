# Rewrite code in spotgear package:
# NB: 1. did not statistically deal with contamination, e.g, the image blobs; currently fixed by hand.
#     2. can put the 2d dewarping into a single function that calls rjags
#     3. can put the posterior sample processing into a separate function so that
#        the processing could be done just based on the results folder.
#     4. can abstract away the peak shape information extraction functions.

# 2nd version: Jan 09, 2017: for primary data analysis section.
# 3rd vresion: Feb 17, 2017: figured out using tf-idf type of feature vector for hierarchical clustering.
# 4th version: Feb 28, 2017: Align the raw data and do hierarchical clustering; put shape info extraction
#                            and rarity weighting towards the end.
# 5th version: Mar 27, 2017: Tested that the code can be run with analysis_id = 8:9; NB: need to add JAGS fitting functions
#              and robustify with respect to lanes with no peaks detected!
# 6th version: Apr 05, 2017: Phenotyped gels.
# 7th version: Nov 18, 2017: Binary factorization with hierarchical Indian Buffet Process (need slides to introduce it).
# 8th version: Jan 15, 2017: Set the data ready for analysis 1) without first lane in the matrix factorization, 2) Adjust for multiple reference lanes (for the binary matrix factorization paper, it seems extra work not to be put into the manuscript.)

rm(list=ls())

# load and attach packages: (nuances about the R file loading system).
library(spotgear)
library(rjags)
library(R2jags)
library(MassSpecWavelet) # <-- for obtaining shape information at each landmark. (will only be used if shape information informs the true and false positive regressions).
library(MKmisc)          # <-- for corDist() to calculate distance based on correlations. (has my own code for calculating correlations, not sure if I'll need it.)

spotgear_globals <- get("package_env",envir=asNamespace("spotgear"))
ref_wt           <- c(21,31,43,66,97,116,200) #spotgear_globals$ref_wt has a 45kda reference, which is not in the new sets of data.
ref_wt2          <- spotgear_globals$ref_wt
colors           <- spotgear_globals$colors
fancy_xlab       <- spotgear_globals$fancy_xlab

logit <- function(x) log(x/(1-x))

#
# TUNING PARAMETERS: (NB: need justification)
#
span         <- 0.022 # The loess span.
w            <- 10    # The half width when computing local scores using sign_score.
score_thres  <- 3     # The threshold of score computed by sign_score, beyond or equal to which a bin will be called peak candidate bin.
sign_diff    <- 0.01  # The minimum autoradiointensity difference a peak must exceed the minimum intensity within a local window defined by w. The larger, the more pronounced a peak is.
break_points <- seq(0,1,length=701) # The points to all gels into bins shared by all gels.

#
# Directory:
#
data_dir <- "~/Documents/professional/data/Livia_Rosen"

#
# Read raw data:
#
n_gel <- 6+4+3 # <--- colon cancer 6 sets; pancreatic cancer 4 sets; prostate cancer 3 sets.
dat_raw_list        <- vector("list",n_gel)
dat_raw_marked_list <- vector("list",n_gel)
phenotype_nm <- c("CANCER,\ NO\ SCLERODERMA/COLON\ CANCER\ SETS\ 1-6", 
                  "CANCER,\ NO\ SCLERODERMA/PANCREATIC\ CANCER\ SETS\ 1-4",
                  "CANCER,\ NO\ SCLERODERMA/PROSTATE\ CANCER\ SETS\ 1-3",
                  "Cancer\ IP\ data")
# The following might be redundant. It might be ultimately more efficient to simplify input of gel sets, or ask the program to recognize the number of
# lanes per gel.

#
# functions that convert ids: (will need to move to the spotgear package.)
#
pair2id <- function(N_g_vec,set_id,lane_id,include_orig_lane1=TRUE){
  if (include_orig_lane1){
    cat("==[spotgear]ID conversions include the original reference lanes. ==\n")
    res <- cumsum(N_g_vec)[set_id-1]+lane_id
  } else{
    cat("==[spotgear]ID conversions DO NOT include the original reference lanes. ==\n")
    res <- cumsum(N_g_vec-1)[set_id] - (N_g_vec[set_id]-lane_id)
  }
  res
} 

#
# END of functions that convert ids.
#
N_g_vec     <- c(20,18,20,20,20,20,   20,20,20,9,   20,20,20) # <-- number of lanes per gel.
index_start <- c(1,7,11) # the 1st, 7th, 11th gel that represents the first of each cancer group.
set_no_vec  <- c(1:6,1:4,1:3) 
# index_start <- c(1,7,11,14)
# set_no_vec <- c(1:6,1:4,1:3,1:4)
PMSCL_machine_lane_id <- c(20,18,16,20,2,20,   20,20,20,NA,   2,20,2,NA,NA,NA,NA) # NB: 2nd one has deleted two empty lanes.
# ?? no ref_lanes? Note that we call the first lane to be the reference lanes, sometimes we call them lane 1s.
# controls do not have identical bands: (lesson - clear documentation of the variable names after the first test of the model.)
# need two ids to identify the control lanes (set id, lane id - prior to removal of the first lane).
control_set_id  <- c(6,6,6,6,6,6,6,6,6,6, 
                   10,10,10,10,
                   13,13,13,13
                   )
control_lane_id <- c(10,11,12,13,14,15,16,17,18,19,
                    3,4,5,6,
                    17,18,19,20
                   )

# the control id if all the lanes are stacked together:
ctrl_in_id <- pair2id(N_g_vec,control_set_id,control_lane_id) #ctrl_in_id <- c(102:111+6,171:174+10,231:234+13) <-- including the original lane 1s.

# identical samples, on two samples. (In one estimation, these two are perfectly aligned. Great!)
calibrator_set_id  <- c(7,10)
calibrator_lane_id <- c(5,2)

#image(t(dat_aligned_analysis[ctrl_in_id,]),1:length(ctrl_in_id),main="controls",col=rev(grDevices::grey(seq(0, 1, length = 256))))
for (s in 1:n_gel){
  set_no <- set_no_vec[s]
  # set up directories:
  if (s < index_start[2]){
    pheno_group <- 1
    data_dir_phenogroup_set <- file.path(file.path(data_dir,phenotype_nm[pheno_group]),paste0("colon\ cancer\ set\ ",set_no))
    dir_raw_tmp <- file.path(data_dir_phenogroup_set,paste0("colon\ cancer\ set\ ", set_no,"_scanned ODs.txt"))
    dir_raw_marked_tmp   <- file.path(data_dir_phenogroup_set, paste0("colon\ cancer\ set\ ", set_no,"_all\ lanes\ report.txt"))
  }
  if(s>= index_start[2] & s < index_start[3]){
    pheno_group <- 2
    # data_dir_phenogroup_set <- file.path(file.path(data_dir,phenotype_nm[pheno_group]),paste0("LIGHT\ EXPOSURES/pancreatic\ cancer\ set\ ",set_no,"_light\ exposure"))
    # dir_raw_tmp <- file.path(data_dir_phenogroup_set,paste0("pancreatic\ cancer\ set\ ", set_no,"\ light_scanned ODs.txt"))
    # dir_raw_marked_tmp   <- file.path(data_dir_phenogroup_set, paste0("pancreatic\ cancer\ set\ ", set_no,"\ light_all\ lanes\ report.txt"))
     data_dir_phenogroup_set <- file.path(file.path(data_dir,phenotype_nm[pheno_group]),paste0("DARK\ EXPOSURES/pancreatic\ cancer\ set\ ",set_no,"_dark\ exposure"))
     dir_raw_tmp <- file.path(data_dir_phenogroup_set,paste0("pancreatic\ cancer\ set\ ", set_no,"\ dark_scanned ODs.txt"))
     dir_raw_marked_tmp   <- file.path(data_dir_phenogroup_set, paste0("pancreatic\ cancer\ set\ ", set_no,"\ dark_all\ lanes\ report.txt"))
  }
  if(s>= index_start[3]){
    pheno_group <- 3
    data_dir_phenogroup_set <- file.path(file.path(data_dir,phenotype_nm[pheno_group]),paste0("prostate\ cancer\ set\ ",set_no))
    dir_raw_tmp <- file.path(data_dir_phenogroup_set,paste0("prostate\ cancer\ set\ ", set_no,"_scanned ODs.txt"))
    dir_raw_marked_tmp   <- file.path(data_dir_phenogroup_set, paste0("prostate\ cancer\ set\ ", set_no,"_all\ lanes\ report.txt"))
    
  }
  # if (s>=index_start[4]){ # cancer but no sc.
  #   pheno_group <- 4
  #   data_dir_phenogroup_set <- file.path(file.path(data_dir,phenotype_nm[pheno_group]),paste0("Set\ ",set_no))
  #   dir_raw_tmp <- file.path(data_dir_phenogroup_set,paste0("Set\ ", s,"\ - scanned ODs.txt"))
  #   dir_raw_marked_tmp   <- file.path(data_dir_phenogroup_set, paste0("Set\ ", s,"\ - all\ lanes\ report.txt"))
  #   
  #   }
  # read data:
  out_tmp <- read_IPdata(dir_raw_tmp,dir_raw_marked_tmp)
  dat_raw_list[[s]]        <- out_tmp[[1]]
  dat_raw_marked_list[[s]] <- out_tmp[[2]]
}

phenotype_label <- c("ColonCancer","PancreaticCancer","ProstateCancer","CancerNoSc")
name_of_gels    <- c(paste("ColonCancer.Set",1:6,sep=""),
                      paste("PancreaticCancer.Set",1:4,sep=""),
                      paste("ProstateCancer.Set",1:3,sep="")
)

# switch lanes for pecularity: reference not on lane one:
for (s in c(5,11,13)){
  tmp <- dat_raw_list[[s]][,c(2,3)] # column 1 is the grid, column 2 in these lanes are for PMScL, column 3 for molecular standards.
  dat_raw_list[[s]][,3:2] <- tmp
}

dat_raw_list[[2]] <- dat_raw_list[[2]][,-(1+c(12,13))] # remove lane 12, 13 from set 2 in colon cancer, because no sample was loaded.

#
# END OF IDENTIFYING CONTROL AND PMSCL LANES AND LANE SWITCHING. ?? No mentioning of reference lanes? Or simply assumed they are all on lane 1s.
#


#
# Smooth and bin data:
#
dat_smoothed_list <- vector("list",n_gel)
dat_binned_list   <- vector("list",n_gel)

for (s in 1:n_gel){# smooth each gel's raw data:
  dat_smoothed_list[[s]]  <- smooth_gel(dat_raw_list[[s]],span)$res # <-- loess smoothing with a span.
  #dat_smoothed_list[[s]] <- dat_raw_list[[s]] # <--- use this if not smoothing first before binning.
}
for (s in 1:n_gel){# bin each gel's smoothed data, according to break_points (specified in the tunning parameter section):
  dat_binned_list[[s]]  <-  bin_gel(dat_smoothed_list[[s]],break_points)
}
for (s in 1:n_gel){# crop right end:
  out_crop <- crop_end(dat_binned_list[[s]],percent=2, bp = break_points) # was 4.4 percent. Apr 2, 2017.
  dat_binned_list[[s]]  <- out_crop[[1]]
  attr(dat_binned_list[[s]],"n_lanes") <- ncol(dat_binned_list[[s]])-2  
}
break_points_cropped   <- out_crop[[2]]

N_g_vec <- unlist(lapply(dat_binned_list,attr,"n_lanes")) # ! warning: this is a second definition of the N_g_vec.
names(N_g_vec) <- 1:length(dat_raw_list)

#
# Local intensity difference scoring by sign:
#
score_mat_list <- vector("list",n_gel)
for (s in 1:n_gel){
  n_g <- attributes(dat_binned_list[[s]])$n_lanes
  score_mat_list[[s]] <- compute_local_relative_score(dat_binned_list[[s]],
                                                      half_width = w,lanes=1:n_g,
                                                      elev_vec = rep(sign_diff,n_g))
}

# get clear peak locations: the elements of the lists are 3 or NA:
score_mat_peak_list <-  vector("list",n_gel)
score_mat_peak_rf   <-  matrix(NA,length(break_points_cropped),ncol=n_gel) # scores (peaks) for the reference lanes.
for (s in 1:n_gel){
  score_mat_peak_list[[s]] <- compute_score_mat_peak(score_mat_list[[s]],score_thres,dat_binned_list[[s]]) # peak index for all lanes
  score_mat_peak_rf[,s]    <- score_mat_peak_list[[s]][,1] # <-- peak index for REFERNCE Lanes could be obtained from this matrix.
}

#
# Plot binned data, detected peaks, and lab scientists' marked peaks.
#
for (s in 1:n_gel){
  curr_dat_raw_marked <- dat_raw_marked_list[[s]]
  pdf(paste0("local_relative_scoring_set_",s,".pdf"),width=20,height=10)
  par(mfrow=c(4,5),oma=c(6,6,0,0))
  n_g    <- attributes(dat_binned_list[[s]])$n_lanes
  t_grid <- break_points_cropped
  
  for (lane in 1:n_g){
    par(mar=c(1,1,1,1))
    curr_yaxt <- "s"
    if (!(lane %in% c(1,6,11,16))){curr_yaxt="n"}
    plot(t_grid,dat_binned_list[[s]][,lane+2],
         type="l",ylim=c(0,1.3),xlab="",
         ylab="",yaxt=curr_yaxt,las=2,xlim=c(0,1),
         cex.lab=1.5,bty="n")
    mtext(paste0("Lane ",lane),3,line = -3,cex=1.5)
    y_cand_bin <- dat_binned_list[[s]][,lane+2]
    y_cand_bin[score_mat_list[[s]][,lane] < score_thres] <- NA
    points(t_grid,y_cand_bin,pch=20,col="blue",type="l",lwd=3)
    if (s<=4){
      curr_dat_raw_marked_lane_ind <- which(curr_dat_raw_marked[,1]==lane)
      #points(curr_dat_raw_marked[curr_dat_raw_marked_lane_ind,3],curr_dat_raw_marked[curr_dat_raw_marked_lane_ind,5],
      #       type="h",col="red")
    }
  }
  mtext(fancy_xlab,1,line=4,cex=1.5,outer = TRUE)
  mtext("Intensity",2,line=4,cex=1.5,outer=TRUE)
  dev.off()
}


#
# paper figure to illustrate the data, landmarks, and misalignment:
#
show_set_id  <- 1
pdf(paste0("Set_",show_set_id,"_show_raw_data.pdf"),width=10,height=10)
par(mfrow=c(3,1),xaxs="i")
n_g <- attributes(dat_binned_list[[show_set_id]])$n_lanes
show_this_data        <- dat_binned_list[[show_set_id]][,-1]
show_this_marked_data <- dat_raw_marked_list[[show_set_id]]

# subplot 1: raw data:
par(mar=c(0,5,5,5))
plot_lane(show_this_data,show_this_marked_data,c(1:n_g),0,FALSE,
          ylim=c(0,1.5),xlim=c(0,1),las=2,xaxt="n",bty="n",cex.axis=1.5,cex.lab=2)
points(show_this_data$rf,show_this_data[,2],col=colors[5],type="l",lwd=3)

# subplot 2: heatmap
par(mar=c(0,5,0,5))
image_gel(show_this_data,cex.lab=2,xaxt="n",xlim=c(0,1),bty="n")
curr_marked <- dat_raw_marked_list[[show_set_id]]
curr_ind    <- which(curr_marked[,1]==1)
#ref_loc     <- sort(curr_marked[curr_ind,3]) # <-- computed from the marked data set.
if (sum(!is.na(score_mat_peak_rf[,show_set_id]))!=length(ref_wt)){ # compute from detected peaks by our algorithm.
  warning(paste0("Detected peaks for gel set ", show_set_id, " inconsistent with known reference proteins!"))
}else{
  ref_loc   <- break_points_cropped[!is.na(score_mat_peak_rf[,show_set_id])]
}
abline(v=ref_loc,col=colors[5],lty=1,lwd=3)

for (curr_lane in 1:n_g){
  # show the algorithms' peaks against grey-scale autoradiographic images:
  points(dat_binned_list[[show_set_id]][score_mat_peak_list[[show_set_id]][,curr_lane] == score_thres,2],
         rep(curr_lane,nrow(dat_binned_list[[s]])), # <---- PLOT.
         lwd=3,pch="*",col="blue",cex=2)
  if (s<=4){
    # annotator's pick:
    curr_ind <- which(dat_raw_marked_list[[s]][,1]==curr_lane)
    #points(dat_raw_marked_list[[s]][curr_ind,3],rep(curr_lane,length(curr_ind)),
    #       pch="|",lwd=3,col="red")
  }
}

# subplot 3: landmark to molecular weight transformation:
par(mar=c(6,5,0,5))
for (s in c(show_set_id,(1:13)[-show_set_id])){
  curr_marked <- dat_raw_marked_list[[s]]
  curr_ind    <- which(curr_marked[,1]==1)
  #ref_loc     <- sort(curr_marked[curr_ind,3])
  
  if (sum(!is.na(score_mat_peak_rf[,s]))!=length(ref_wt)){ # compute from detected peaks by our algorithm.
    warning(paste0("Detected peaks for gel set ", s, " inconsistent with known reference proteins!"))
  }else{
    ref_loc   <- break_points_cropped[!is.na(score_mat_peak_rf[,s])]
  }
  
  if (s==show_set_id){
    plot(ref_loc,rev(ref_wt),#pch=as.character(s),
         pch=20,
         type="o",
         ylim=c(0,220),
         xlim=c(0,1),
         xaxs="i",yaxt="n",
         ylab="Weight (kDa)",col=colors[5],las=1,cex.lab=2,cex=3,lwd=0.9,
         xlab="Location on gel (t); Corresponding weight on Y-axis",bty="n",
         xaxt="n")
    # axis(side = 1,labels = rev(ref_wt),ref_loc)
    axis(side = 1,labels = c(0,0.2,0.4,0.6,0.8,1),c(0,0.2,0.4,0.6,0.8,1),cex.axis=2)
  } else{
    points(ref_loc,rev(ref_wt),type="o",#pch=as.character(s),
           pch=1,lwd=1.5,
           col="gray",cex=3)
  }
  if (s==show_set_id){
    arrows(ref_loc,y1=rev(ref_wt),y0=225,lty=1,col=colors[5],lwd=3,length=0.1)
    arrows(rev(ref_wt),x0=ref_loc,x1=0,lty=1,col=colors[5],lwd=3,length=0.1)
  }
  
  # segments(rep(0,length(ref_wt)),ref_loc,ref_wt,ref_loc,
  #          col=s)
}
axis(2,at=ref_wt,labels = ref_wt,las=2)
dev.off()


#
# Correct batch effects by reference lanes:
#
set_id_aligned_to     <- 1
dat_binned_aligned_to <- dat_binned_list[[set_id_aligned_to]]

for (query_set_id in 1:13){
  dat_binned_query      <- dat_binned_list[[query_set_id]]
  n_lanes_query         <- attributes(dat_binned_query)$n_lanes
  
  out_batch_align <- correct_batch_effect_by_ref(dat_binned_query,
                                                 dat_binned_aligned_to,
                                                 score_mat_peak_list[[query_set_id]],
                                                 score_mat_peak_list[[set_id_aligned_to]],
                                                 break_points_cropped,
                                                 score_thres)
  ref_loc     <- out_batch_align$ref_loc
  warped_ind  <- out_batch_align$warped_ind
  
  pdf(paste0("Set_",query_set_id,"_to_Set_",set_id_aligned_to,"comparison_before_and_after_batch_effect_correction.pdf"),
      width=10,height=6)
  par(mar=c(5,5,5,1))
  # plot piecewise linear warping results:
  # with warping:
  plot(dat_binned_aligned_to[,2],
       dat_binned_aligned_to[,3],
       type="l",col=colors[5],ylim=c(-1.2,1.2),
       ylab="Intensity",xlab="Molecular Weight (kDa)",
       yaxt="n",lwd=3,cex.lab=2,xaxt="n",bty="n")
  axis(1,at=ref_loc,labels = rep("",length(ref_loc)),las=1,cex=2,pos = 0)
  text(ref_loc,rep(0,length(ref_loc)), ref_wt)
  
  axis(2,at=c(seq(-1.2,1.2,by=0.2)),labels=abs(round(c(seq(-1.2,1.2,by=0.2)),1)),las=1)
  points(dat_binned_aligned_to[,2],
         dat_binned_query[warped_ind,3],type="l",
         col=query_set_id,lwd=2,lty=4)
  
  legend("top",paste("Refence Lane for Gel Set ",query_set_id,sep=""),col=query_set_id,
         lty=c(4,1,1),
         bty="n",cex = 1.5,horiz = TRUE,lwd=c(2,2,2))
  legend("bottom",paste("Refence Lane for Gel Set ",set_id_aligned_to,sep=""),col=colors[5],
         lty=1,
         bty="n",cex = 1.5,horiz = TRUE,lwd=c(2))
  # without warping:
  points(dat_binned_aligned_to[,2],-dat_binned_aligned_to[,3],type="l",col=colors[5],lwd=3)
  points(dat_binned_aligned_to[,2],-dat_binned_query[,3],type="l",col=query_set_id,lty=4,lwd=2)
  
  mtext(paste0("Gel ",query_set_id, " aligned towards Gel Set ",set_id_aligned_to),3,cex=3,line=1)
  
  for (lane in 2:n_lanes_query){
    # with warping:
    points(dat_binned_aligned_to[,2],dat_binned_query[warped_ind,lane+2],type="l",
           col=colors[10])
    # without warping:
    points(dat_binned_aligned_to[,2],-dat_binned_query[,lane+2],type="l",col=colors[10])
  }
  dev.off()
}

#
# Create piecewise linearly dewarped gels.
#
dat_binned_batch_aligned_list <- vector("list",n_gel)
for (s in 1:n_gel){
  dat_binned_batch_aligned_list[[s]] <- create_batch_aligned_data(dat_binned_list,
                                                                  score_mat_peak_list,
                                                                  query_id = s,
                                                                  ref_id  = set_id_aligned_to,
                                                                  break_points_cropped,
                                                                  score_thres)
}

# show dewarpped binned data:
pdf(paste0("check_reference_lanes_to_gel_",set_id_aligned_to,".pdf"),width=10,height=6)
par(mar=c(5,5,5,2))
plot(dat_binned_batch_aligned_list[[set_id_aligned_to]][,2],
     dat_binned_batch_aligned_list[[set_id_aligned_to]][,3],
     type="l",ylim=c(0,0.5),col=1,xlab="Molecular Weight (kDa)",ylab="Intensity",
     bty="n",xaxt="n",lwd=3,cex.lab=2)
axis(1,at=ref_loc,labels = rep("",length(ref_loc)),las=1,cex=2,pos = 0)
text(ref_loc,rep(0,length(ref_loc)), ref_wt)
mtext(paste0("Reference Lanes aligned towards Gel ", set_id_aligned_to),line = -1,cex=2)
for (s in (1:n_gel)[-set_id_aligned_to]){
  points(dat_binned_batch_aligned_list[[s]][,2],dat_binned_batch_aligned_list[[s]][,3],type="l",col=colors[s])
}
dev.off()


#
#
# Do peak detection again.
# NB: !! Necessary because after correction for batch effects, the serum lanes have been
# stretched or compressed, changing the location for peaks compared to ones detected
# using the binned data prior to batch effect correction.
#
#
score_mat_batch_aligned_list <- vector("list",n_gel)
for (s in 1:n_gel){
  n_g <- N_g_vec[s]
  score_mat_batch_aligned_list[[s]] <- compute_local_relative_score(dat_binned_batch_aligned_list[[s]],
                                                                    half_width = w,
                                                                    lanes=1:n_g,
                                                                    elev_vec = rep(sign_diff,n_g))
}

# get clear peak locations: (3 or NA)
score_mat_peak_batch_aligned_list <-  vector("list",n_gel)
score_mat_peak_batch_aligned_rf   <-  matrix(NA,length(break_points_cropped),ncol=n_gel) # scores (peaks) for the reference lanes.
for (s in 1:n_gel){
  score_mat_peak_batch_aligned_list[[s]] <- compute_score_mat_peak(score_mat_batch_aligned_list[[s]],
                                                                   score_thres,dat_binned_batch_aligned_list[[s]]) # peak index for all lanes
  score_mat_peak_batch_aligned_rf[,s]    <- score_mat_peak_batch_aligned_list[[s]][,1] # <-- peak index for REFERNCE Lanes could be obtained from this matrix.
}

# plot intensity curves, peaks after batch-effect correction based on reference lanes:
for (s in 1:n_gel){
  curr_dat_raw_marked <- dat_raw_marked_list[[s]]
  pdf(paste0("batch_corrected_local_relative_scoring_set_",s,".pdf"),width=20,height=10)
  par(mfrow=c(4,5),oma=c(6,6,0,0))
  n_g    <- attributes(dat_binned_list[[s]])$n_lanes
  t_grid <- break_points_cropped
  
  for (lane in 1:n_g){
    par(mar=c(1,1,1,1))
    curr_yaxt <- "s"
    if (!(lane %in% c(1,6,11,16))){curr_yaxt="n"}
    plot(t_grid,dat_binned_batch_aligned_list[[s]][,lane+2],
         type="l",ylim=c(0,1.3),xlab="",
         ylab="",yaxt=curr_yaxt,las=2,xlim=c(0,1),
         cex.lab=1.5,bty="n")
    mtext(paste0("Lane ",lane),3,line = -3,cex=1.5)
    y_cand_bin <- dat_binned_batch_aligned_list[[s]][,lane+2]
    y_cand_bin[score_mat_batch_aligned_list[[s]][,lane] < score_thres] <- NA
    points(t_grid,y_cand_bin,pch=20,col="blue",type="l",lwd=3)
    if (s<=4){
      curr_dat_raw_marked_lane_ind <- which(curr_dat_raw_marked[,1]==lane)
      points(curr_dat_raw_marked[curr_dat_raw_marked_lane_ind,3],curr_dat_raw_marked[curr_dat_raw_marked_lane_ind,5],
             type="h",col="red")
    }
  }
  mtext(fancy_xlab,1,line=4,cex=1.5,outer = TRUE)
  mtext("Intensity",2,line=4,cex=1.5,outer=TRUE)
  dev.off()
}

# plot heatmap with detected peaks after batch correction:
for (s in 1:n_gel){
  n_g <- N_g_vec[s]
  pdf(paste0("peaks_overlaid_heatmap_set_batch_corrected_",s,".pdf"),width=8,height=6)
  image_gel(dat_binned_batch_aligned_list[[s]][,-c(1)])
  for (curr_lane in 1:n_g){
    # show the algorithms' peaks against grey-scale autoradiographic images:
    points(dat_binned_batch_aligned_list[[s]][score_mat_peak_batch_aligned_list[[s]][,curr_lane] == score_thres,2],
           rep(curr_lane,nrow(dat_binned_batch_aligned_list[[s]])), # <---- PLOT.
           lwd=3,pch="*",col="blue")
    if (s<=4){
      # annotator's pick:
      curr_ind <- which(dat_raw_marked_list[[s]][,1]==curr_lane)
      #points(dat_raw_marked_list[[s]][curr_ind,3],rep(curr_lane,length(curr_ind)),
      #       pch="|",lwd=3,col="red")
    }
  }
  dev.off()
}


#
# Bayesian 2d image dewarping for PMScL machines:
#

#dat_PMScL_batch_aligned <- sapply(c(1:9,11:13), function(s) {dat_binned_batch_aligned_list[[s]][,2+PMSCL_machine_lane_id[s]]})
#image(dat_PMScL_batch_aligned)

# 
# pdf("PMScL_dtw.pdf",height=8,width=12)
# X <- t(dat_PMScL_batch_aligned)
# library(dtw);
# template <- X[1,]
# par(mfrow=c(3,4))
# count <- 0
# for (l in 2:12){
#   count <- count+1
# query <- X[l,]
# alignment<-dtw(query,template,keep=TRUE,
#                step=rabinerJuangStepPattern(6,"c"))
# 
# #plot(template)
# #lines(query[alignment$index1]~alignment$index2,col="blue")
# 
# #plot(alignment,type="twoway",offset=-0.1)
# 
# 
# 
# #if (count==1){
# #   plot(template[alignment$index2],type="l",col="black")
# #} else {
# #   points(template[alignment$index2],type="l",col="black")
# #  }
# #points(query[alignment$index1],type="l",col=l)
# 
# res <- dtwclust::SBD(template,X[l,])
# 
# plot(X[1,],type="l")
# #points(X[4,],type="l",col="red")
# points(res$yshift,type="l",col="blue")
# 
# }
# dev.off()

# res <- dtwclust::SBD(X[1,],X[3,])
# 
# plot(X[1,],type="l")
# points(X[4,],type="l",col="red")
# points(res$yshift,type="l",col="blue")


#
# Up to now, gels are reference aligned with peaks detected. Ready for 
# cross-gel dewarping to align proteins shared across gel sets.
#

#------------------------------------------------------------------------------#
# Dewarping the gels (Bayesian 2D de-warping): [CORE CODE]
#------------------------------------------------------------------------------#

# organize data for all gels:
trunc_range   <- range(dat_binned_batch_aligned_list[[1]]$rf)
normalized_rf <- (dat_binned_batch_aligned_list[[1]]$rf-trunc_range[1])/(trunc_range[2]-trunc_range[1]) # <----- changed rf.!!!!

#
# set analysis id
# 

#analysis_id    <- 1:6; label_id <- 1
#analysis_id    <- 7:10; label_id <- 2
#analysis_id    <- 11:13; label_id <- 3
analysis_id     <- 1:13; label_id <- 1
REPLICATE           <- !TRUE
# get lane ids for pmscl machines:
# assuming each gel has at most one PMSCL machine:
analysis_pmscl_ind0 <- pair2id(N_g_vec[analysis_id],analysis_id,PMSCL_machine_lane_id[analysis_id],FALSE)#(cumsum(N_g_vec[analysis_id]-1) - (N_g_vec[analysis_id] - PMSCL_machine_lane_id[analysis_id]))
analysis_pmscl_ind  <- analysis_pmscl_ind0[!is.na(analysis_pmscl_ind0)] # gel 10 does not have PMSCL machine.

dat_for_dewarp <- build_data_for_dewarping(score_mat_peak_batch_aligned_list,
                                           analysis_id,normalized_rf,N_g_vec)


# visualize all the peaks by ggplot2: (include original reference lane 1s).
g <- ggplot2::ggplot(dat_for_dewarp,ggplot2::aes(x=Y,y=lane_ID,group=gel_ID,color=gel_ID))+
  ggplot2::geom_point(shape="*",size=5)+ggplot2::facet_wrap(~gel_ID,nrow=4)
g

# fit bayesian dewarping model:
Date             <- gsub("-", "_", Sys.Date())
result_folder    <- file.path("/Users/zhenkewu/Dropbox/ZW/professional/=research_agenda/collaborative/Scleroderma/protein-electrophoresis/phenotyped_gel",paste0("dewarp_",paste(analysis_id,collapse="_")))
dir.create(result_folder)

# All document names:
docs <- list.files(result_folder,pattern = "*.txt")   

if (length(docs)>0){
  # Remove all documents with file.size = 1 from the directory
  file.remove(file.path(result_folder,docs))
}

# fit Bayesian model:
mcmc_options <- list(debugstatus = TRUE,
                     n.chains   = 1,
                     n.itermcmc = 2000,
                     n.burnin   = 1000,
                     n.thin     = 1,
                     result.folder = result_folder,
                     bugsmodel.dir = result_folder,
                     jags.dir = ""
)

source("pmscl_machine.R")
gs <- dewarp2d_machine(dat_for_dewarp,mcmc_options,analysis_pmscl_ind)

#
# checked up to here: the data dat_for_dewarp contains lane 1. So can play with this data set!!
#


#
# Posterior sample analyses:
#
DIR_DEWARP <- result_folder
#DIR_DEWARP <- "/Users/zhenkewu/Downloads/gel_bayes_spotgear/dewarp_all/2000 result jags"

out_dewarp <- read_dewarp_folder(DIR_DEWARP)
bugs.dat   <- out_dewarp$bugs.dat
res_dewarp <- out_dewarp$res_dewarp

#
# Collect data used during model fitting:
#

T1         <- bugs.dat$T1
T2         <- bugs.dat$T2
G          <- bugs.dat$G 
N_gel      <- G
L          <- bugs.dat$L
curr_dat   <- subset(dat_for_dewarp,lane_ID!=1)
N_per_gel  <- bugs.dat$N_per_gel
Y_std      <- bugs.dat$Y_std
v_landmark <- bugs.dat$v_landmark
N_all_gel  <- bugs.dat$N_all_gel
gel_id     <- bugs.dat$gel_id
in_gel_id     <- bugs.dat$in_gel_id
ZBu        <- bugs.dat$ZBu
ZBv        <- bugs.dat$ZBv

beta_ident <- bugs.dat$beta_ident
lookup     <- bugs.dat$lookup
n_vec      <- bugs.dat$n_vec


#
#
#

print_res <- function(x) plot(res_dewarp[,grep(x,colnames(res_dewarp))])
get_res   <- function(x) res_dewarp[,grep(x,colnames(res_dewarp))]

beta_samp <- get_res("^beta\\[")
beta_samp_array <- array(t(beta_samp),c(T1,T2,N_gel,nrow(beta_samp)))

S_array <- function(mat) {
  tmp_list <- list()
  for (g in 1:G){
    curr_mat <- as.matrix(mat[,,g])
    tmp <- ZBu[1:N_per_gel[g],,g]%*%curr_mat%*%t(ZBv)
    if (max(tmp)>v_landmark[L+2]+1.001 | min(tmp)< v_landmark[1]-0.001){
      stop("==shape constraint failed for the warping.==")
    }
    tmp_list[[g]] <- tmp
  }
  do.call(rbind,tmp_list)
}

curr_S_hat0 <- S_array(apply(beta_samp_array,c(1,2,3),mean))

# pdf("persp_dewarping.pdf",width=10,height=12)
# par(mfrow=c(length(analysis_id),2))
# for (g in 1:G){
#   curr_S_hat <- curr_S_hat0[gel_id==g,]
#   persp(v_landmark,u_obs_list[[g]],t(curr_S_hat),#zlim=c(-0.001,1.001),
#         xlab="location along the gel",
#         ylab="lanes",
#         zlab="warped location",
#         theta = -25,phi=35,main=paste0("Gel Set ",g))
#   
#   curr_z_diff <- curr_S_hat-t(replicate(v_landmark,n=N_per_gel[g]))
#   
#   persp(v_landmark,u_obs_list[[g]],t(curr_z_diff),#zlim=c(-0.001,1.001),
#         xlab="location along the gel",
#         ylab="lanes",
#         zlab="warped difference",
#         theta = -25,phi=35,main=paste0("Gel Set ",analysis_id[g]))
# }
# dev.off()

z_diff <- curr_S_hat0-t(replicate(v_landmark,n=sum(N_per_gel)))

# # observed peaks:
# plot(Y_std,lane_ID_stacked[dat_for_dewarp$lane_ID!=1],col="blue",pch=20,cex=2, # <-- has excluded lane 1.
#      xlim=c(-2,3),xlab="location along the gel",
#      ylab="serum sample lane",yaxt="n")
# axis(2,at=unique(sort(lane_ID_stacked[dat_for_dewarp$lane_ID!=1])),
#      labels=rep(seq_along(u_obs),N_gel)+1,las=1)
# 
# # grid points:
# points(expand.grid(v_landmark,unique(lane_ID_stacked[dat_for_dewarp$lane_ID!=1])),pch="+")
# # warping:
# for (i in seq_along(v_landmark)){
#   points(z_diff[,i]+v_landmark[i],unique(lane_ID_stacked[dat_for_dewarp$lane_ID!=1]),type="l",cex.lab=2,lty=1)
# }

# get the alignment:
Z_samp <- get_res("^Z")
get_prob <- function(vec,L){
  count <- rep(0,(L+2))
  for (j in 1:(L+2)){
    count[j] <- sum(vec==j)
  }
  count/length(vec)
}
Z_post_prob    <- apply(Z_samp,2,get_prob,L=L)
Z_map_marginal <- apply(Z_post_prob,2,which.max)
#Z_top       <- apply(Z_post_prob,2,function(x) x[order(x,decreasing = TRUE)[1:3]])

# #
# # Compute Least Squares De-Warping:
# #
# Z_array      <- array(0,c(ncol(Z_samp),length(v_landmark),nrow(Z_samp)))
# Z_outer_prod <- array(0,c(ncol(Z_samp),ncol(Z_samp),nrow(Z_samp)))
# Z_SE         <- rep(0,length=nrow(Z_samp))
# for (iter in 1:nrow(Z_samp)){
#   Z_array[cbind(1:ncol(Z_samp),Z_samp[iter,],iter)] <- 1
#   Z_outer_prod[,,iter] <- Z_array[,,iter]%*%t(Z_array[,,iter])
# }
# 
# mean_Z_op <- apply(Z_outer_prod,c(1,2),mean)
# for (iter in 1:nrow(Z_samp)){
#   Z_SE[iter] <- sum((Z_outer_prod[,,iter]-mean_Z_op)^2)
# }
# Z_map <- Z_samp[which.min(Z_SE),]
# 
# cbind(Z_map,Z_map_marginal)[which(Z_map!=Z_map_marginal),]

Z_map <- Z_map_marginal

# aRI_aligned <- VI_aligned <- rep(NA,nrow(Z_samp))
# aRI_naive   <- VI_naive <- rep(NA,nrow(Z_samp))
# comparison_results <- array(NA,c(2,2,nrow(Z_samp)))
# 
# for (iter in 1:nrow(Z_samp)){
#Z_map <- Z_samp[iter,]

#
# SOME ISSUES BELOW:
#

# #
# # plot marginal probabilities of being aligned to a location:
# #
# tmp  <- get_res("normalized_probmat")
# tmp2 <- 1-exp(-1*tmp) # superposition of N Poisson processes, or 1-(1-(1-exp(-tmp)))^N. !!
# pdf(paste0("probability_of_protein_aligned_single_lane_",paste(analysis_id,collapse="_"),".pdf"),width = 10,height=6)
# par(xpd=NA)
# # res_probalign <- barplot(colMeans(tmp2),#type="h",
# #                          ylim=c(0,1),las=2,
# #                          xlab="Molecular Weight Landmark #",
# #                          ylab="probability of having a protein",
# #                          cex.lab=1.5,main=phenotype_label[label_id],xaxt="n")
# # axis(1,at = res_probalign[(1:(L/2+1))*2-1],labels = (1:(L/2+1))*2-2,cex.axis=0.8,padj = -1)
# # axis(1,at = res_probalign[(1:(L/2+1))*2],labels = (1:(L/2+1))*2-1,cex.axis=0.8,padj = -2)
# #
# # text(sapply(ref_loc,function(x) which.min(abs(x-zero_to_one_v_landmark))),
# #      -0.2,labels = (ref_wt),cex=1,col="dodgerblue2")
# 
# plot(zero_to_one_v_landmark,colMeans(data_lcm_all),type="h",
#         ylim=c(0,1),las=2,
#         xlab="Molecular Weight Landmark # (actual marker weights in blue)",
#         ylab="Fraction of Samples Aligned to the Landmark",
#         cex.lab=1.5,main=phenotype_label[label_id],xaxt="n")
# axis(1,at = zero_to_one_v_landmark[(1:(L/2+1))*2-1],labels = (1:(L/2+1))*2-2,cex.axis=0.8,padj = -1)
# axis(1,at = zero_to_one_v_landmark[(1:(L/2+1))*2],labels = (1:(L/2+1))*2-1,cex.axis=0.8,padj = -2)
# 
# text(dat_binned_batch_aligned_list[[set_id_aligned_to]][which(!is.na(score_mat_peak_batch_aligned_list[[set_id_aligned_to]][,1]==3)),2],
#      -0.15,labels = rev(ref_wt),cex=1,col="dodgerblue2")
# 
# # plot(colMeans(tmp2),type="h",ylim=c(0,1),las=2,
# #      xlab="location (molecular weight)",
# #      ylab="probability of having a protein",
# #      cex.lab=1.5,main=paste0("ALL Gels "))
# dev.off()



#
# SOME ISSUES ABOVE!
#

#
# plot observed peaks, grid points and warping function:
#
lane1_number <- c(0,cumsum(1+N_per_gel)[-G])+1
lane_ID_stacked <- curr_dat$lane_ID_stacked
pdf(paste0("Bayesian_warping_gel_",paste0("dewarp_",paste(analysis_id,collapse="_")),".pdf"),width=10,height=6*G)
par(mar=par()$mar+c(3,0,0,0),xpd=NA)
# observed peaks:
plot(Y_std,lane_ID_stacked,col="blue",pch=20,cex=1,
     xlim=c(v_landmark[1],v_landmark[L+2]),
     xlab="",
     ylab="Serum Sample Lane",yaxt="n",bty="n",xaxt="n")
mtext("Landmark #",side = 1, line=6)
# grid points:
points(expand.grid(v_landmark,sort(unique(lane_ID_stacked))),pch="+",col="pink")
# "matched-to" grid points
points(v_landmark[Z_map],lane_ID_stacked,col="red",pch=2,cex=1,lwd=2,
       xlab="location along the gel",
       ylab="serum sample lane",yaxt="n")
segments(Y_std,lane_ID_stacked,
         v_landmark[Z_map],lane_ID_stacked,lwd=2,col="red")
axis(2,at=unique(sort(lane_ID_stacked)),labels=in_gel_id+1,las=1)
# warping function by grid points:
loc_weight_in_lane1 <- subset(build_data_for_dewarping(score_mat_peak_batch_aligned_list,
                                                       set_id_aligned_to,normalized_rf,N_g_vec),gel_ID==set_id_aligned_to & lane_ID==1)$Y

text(rep((loc_weight_in_lane1-mean(dat_for_dewarp$Y))/sd(dat_for_dewarp$Y),G),
     lane1_number+0.5,labels = rev(ref_wt),cex=1)

for (g in 1:G){
  this_gel_lanes <- which(gel_id==g)
  for (i in seq_along(v_landmark)){
    points(z_diff[this_gel_lanes,i]+v_landmark[i],unique(sort(lane_ID_stacked))[this_gel_lanes],
           type="l",cex.lab=2,lty=1)
    #text(rep(v_landmark[i],G),lane1_number,labels = i-1,cex=0.5)
  }
  text(x = v_landmark[(1:(L/2+1))*2-1],y=rep(lane1_number[g],L/2+1)-0.5,labels = (1:(L/2+1))*2-2,cex=0.5)
  text(x = v_landmark[(1:(L/2+1))*2],  y=rep(lane1_number[g],L/2+1)-0.25,labels = (1:(L/2+1))*2-1,cex=0.5)
  
}
text(rep(v_landmark[1]-0.1,G),0.5+lane1_number+9,
     paste("Gel ", analysis_id[1:G],sep=""),cex=2,srt=90)

for (l in seq_along(v_landmark)){
  segments(v_landmark[l],-3,
           v_landmark[l],-3+5*colMeans(tmp2)[l],
           #ylim=c(0,1),las=2,
           #xlab="Molecular Weight Landmark #",
           #ylab="probability of having a protein",
           cex=1.5#，main=paste0("ALL Gels "),xaxt="n"，#type="h"
  )
}
axis(1,at = v_landmark[(1:(L/2+1))*2-1],labels = (1:(L/2+1))*2-2,cex.axis=0.4,padj = 0,line = 3)
axis(1,at = v_landmark[(1:(L/2+1))*2],labels = (1:(L/2+1))*2-1,cex.axis=0.4,padj = -1,line=3)

dev.off()


# #
# # making the gel dewarp process animation:
# #
# 
# # some data preparation:
# library(animation)
# Sys.setenv(PATH="/usr/local/Cellar/imagemagick/6.9.6-4/bin:/opt/local/bin:/opt/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/texbin/:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Library/TeX/texbin")
# Sys.getenv()
# nyears <- length(fr.mort$year)
# w_seq <- seq(0,1,length=10)
# makeplot <- function(){
#   for(i in seq_along(w_seq))
#   {
#     w <- w_seq[i]
#     # observed peaks:
#     curr_position <- (1-w)*Y_std+w*v_landmark[Z_map]
#     plot(curr_position,(lane_ID_stacked[dat_for_dewarp$lane_ID!=1]),col="blue",pch=20,cex=1,
#          xlim=c(v_landmark[1],v_landmark[J+2]),
#          xlab="location along the gel",
#          ylab="serum sample lane",yaxt="n")
#     # grid points:
#     points(expand.grid(v_landmark,sort(unique(lane_ID_stacked[dat_for_dewarp$lane_ID!=1]))),pch="+",col="pink")
#     # "matched-to" grid points
#     points(v_landmark[Z_map],lane_ID_stacked[dat_for_dewarp$lane_ID!=1],col="red",pch=2,cex=1,lwd=2,
#            xlab="location along the gel",
#            ylab="serum sample lane",yaxt="n")
#     segments(curr_position,lane_ID_stacked[dat_for_dewarp$lane_ID!=1],
#              v_landmark[Z_map],lane_ID_stacked[dat_for_dewarp$lane_ID!=1],lwd=2,col="red")
#     axis(2,at=unique(sort(lane_ID_stacked[dat_for_dewarp$lane_ID!=1])),labels=rep(seq_along(u_obs)+1,N_gel),las=1)
#     # warping function by grid points:
#     loc_weight_in_lane1 <- subset(dat_for_dewarp,gel_ID==4 & lane_ID==1)$Y
#     
#     text(rep((loc_weight_in_lane1-mean(dat_for_dewarp$Y))/sd(dat_for_dewarp$Y),N_gel),
#          lane1_number+0.5,labels = rev(ref_wt),cex=1)
#     
#     for (g in 1:N_gel){
#       this_gel_lanes <- which(gel_id==g)
#       for (i in seq_along(v_landmark)){
#         points((1-w)*(z_diff[this_gel_lanes,i]+v_landmark[i])+w*(v_landmark[i]),unique(sort(lane_ID_stacked[dat_for_dewarp$lane_ID!=1]))[this_gel_lanes],
#                type="l",cex.lab=2,lty=1)
#         text(rep(v_landmark[i],N_gel),lane1_number,labels = i,cex=0.5)
#       }
#     }
#     text(rep(v_landmark[1]-0.1,N_gel),0.5+lane1_number+9,
#          paste("Gel ", (1:N_gel),sep=""),cex=2,srt=90)
#   }
# }
# oopt = ani.options(interval = 0, nmax = length(w_seq))
# animation:::saveMovie(makeplot(),interval = 0.2, ani.width=600,ani.height= 800)
# ani.options(oopt)


#
# MUST CHECK whether the data below contains the reference lanes!
#

# Construct Alignment Data Z; Could be used for latent class analysis:
data_lcm <- matrix(0,nrow=N_all_gel,ncol=L+2) # N_all_gel does not include lane 1.
for (i in 1:N_all_gel){ #i th person:
  curr_ind <- lookup[i,1:n_vec[i]]
  # p th peak:
  for (p in curr_ind){ # aligned to res_Z:
    data_lcm[i,Z_map[p]] <- 1
  }
}

make_lane_name <- function(id,N,start=rep(1,length(id))) {
  res <- NULL
  for (s in seq_along(id)){
    res <- c(res,paste("Set.",id[s],"_Lane.",start[s]:N[s],sep=""))
  }
  res
}
# 
# # see aligned results:
# plot(v_landmark[Z_map],lane_ID_stacked,col="red",pch="|",cex=1,lwd=2,
#      xlim=c(v_landmark[1],v_landmark[L+2]),xlab="location along the gel", #
#      ylab="serum sample lane",yaxt="n",main="All Gels") # #
# axis(2,at=unique(sort(lane_ID_stacked)),labels=in_gel_id+1,las=1)
# 

## need to fix the scenario where no peaks were observed.
# pick_lane_without_peaks_list <- vector("list",length(N_per_gel))
# for (s in 1:n_gel){
#   pick_lane_without_peaks_list[[s]] <- colSums(!is.na(score_mat_peak_batch_aligned_list[[s]]))
# }
# ind_lane_nopeak <- which(unlist(pick_lane_without_peaks_list)==0)
# inserted_tmp <- data_lcm
# for (r in ind_lane_nopeak){
#   inserted_tmp <- rbind(inserted_tmp[1:(r-1),],rep(0,L+2),inserted_tmp[-(1:(r-1)),])
# }

data_lcm_all           <- data_lcm

rownames(data_lcm_all) <- make_lane_name(analysis_id,N_per_gel+1,rep(2,length(analysis_id)))

zero_to_one_v_landmark <- v_landmark*sd(curr_dat$Y)+mean(curr_dat$Y)

dat_without_lane1      <- curr_dat # ok, this data does not have reference lane 1s.

# ISSUES BELOW:
# piecewise linear warping using the downsampled landmarks:
# #
pdf(paste0("pwl_after_dewarping_",paste0("dewarp_",paste(analysis_id,collapse="_")),".pdf"),height=16,width=8)
par(mfrow=c(N_gel,1))
ct <- 0
dat_tmp_pwl_after_dewarping_list <- dat_binned_batch_aligned_list[analysis_id]
ref_index_list                   <- vector("list",length(analysis_id))
for (s in seq_along(analysis_id)){
  g <- analysis_id[s]
  curr_n_lanes <- attributes(dat_binned_batch_aligned_list[[g]])$n_lanes
  ref_index_list[[s]] <- vector("list",curr_n_lanes) # <-- need to change 19 to the no. of lanes.
  for (l in 2:(N_per_gel[s]+1)){
    tmp_pwl <- pwl_after_dewarping(g,l,normalized_rf,curr_dat,data_lcm_all,zero_to_one_v_landmark,
                                   s,l-1,N_per_gel,Z_map,n_vec,lookup)
    ref_index_list[[s]][[l-1]] <- tmp_pwl$ref_index
    dat_tmp_pwl_after_dewarping_list[[s]][,l+2] <- dat_binned_batch_aligned_list[[g]][tmp_pwl$warped_ind,l+2]
  }
  par(mar=c(0,2,0,2))
  image(as.matrix(dat_tmp_pwl_after_dewarping_list[[s]][,-c(1:3)]),col=rev(grey(seq(0,1,length=256))))
}
dev.off()
#
# ISSUES ABOVE!
#

landmark_index_vec     <- sapply(zero_to_one_v_landmark,function(v) which.min(abs(normalized_rf-v)))

#------------------------------------------------------------------------------#
# Clustering analysis: Subset and Signature Estimation:
#------------------------------------------------------------------------------#
#
# helper functions:
#

# visualize Livia's information:
color_vec <- c("red","green","blue")
YlGnBu5   <- c('#ffffd9','#c7e9b4','#41b6c4','#225ea8','#081d58',"#092d94")
hmcols    <- colorRampPalette(YlGnBu5)(256)
cols      <- rainbow(4)

highlight <- list()

# #
# # hightlight cancer types:
# #
#  
# highlight[[1]] <- make_lane_name(1:6,N_per_gel[1:6]+1) # N_per_gel does not have ref lanes.
# highlight[[2]] <- make_lane_name(7:10,N_per_gel[7:10]+1)
# highlight[[3]] <- make_lane_name(11:13,N_per_gel[11:13]+1)


#
# highlight control lanes:
#
highlight <- list()
highlight[[1]] <- make_lane_name(c(6,10,13),c(19,6,20),start=rep(10,3,17))
highlight[[2]] <- make_lane_name(c(1:9,11:13),PMSCL_machine_lane_id[c(1:9,11:13)],start=PMSCL_machine_lane_id[c(1:9,11:13)])

## function to change color etc. of a leaf
colorLeafs <- function(x) {
  for (s in seq_along(highlight)){
    if (is.leaf(x) && attr(x, "label") %in% highlight[[s]]) {
      attr(x, "nodePar") <- list(lab.col=color_vec[s], pch=NA)
    }
  }
  return(x)
}

norm_vec      <- function(x) sqrt(sum(x^2))
mynormalize   <- function(mat) {
  res <- mat-replicate(ncol(mat),rowMeans(mat)) # mat is row-wise centered.
  diag(1/apply(res,1,norm_vec))%*%as.matrix(res)
}

#
# Aligned hierarchical clustering: dat_tmp_pwl_after_dewarping_list
#
# -c(1:2) includes reference lane 1; -c(1:3) excludes reference lane 1:
dat_aligned_analysis <- dat_tmp_pwl_after_dewarping_list[[1]][,-c(1:3)]
for (s in 2:length(analysis_id)){
  dat_aligned_analysis <- cbind(dat_aligned_analysis, dat_tmp_pwl_after_dewarping_list[[s]][,-c(1:3)])
}

curr_serum_names <- make_lane_name(analysis_id,N_per_gel+1,start=rep(2,length(analysis_id)))
colnames(dat_aligned_analysis) <- curr_serum_names
#colnames(dat_aligned_analysis) <- c(make_lane_name(analysis_id[-5],N_per_gel+1),set5_names)#make_lane_name(analysis_id,N_per_gel+1)

ty  <- rep(4,ncol(dat_aligned_analysis))
for (l in 1:ncol(dat_aligned_analysis)){
  for (s in seq_along(highlight)){
    if (curr_serum_names[l]%in%highlight[[s]]){
      ty[l] <- s
    }
  }
}

dat_aligned_analysis <- t(dat_aligned_analysis)

#dist_mat_aligned <- MKmisc::corDist(dat_aligned_analysis,method="pearson") # "kendall", "spearman"

unit_dat_aligned_analysis <- mynormalize(dat_aligned_analysis)
curr_N_all <- nrow(dat_aligned_analysis)
mat_aligned <- matrix(NA,nrow=curr_N_all,ncol = curr_N_all)
for (j in 1:(curr_N_all-1)){
  for (i in (j+1):curr_N_all){
    mat_aligned[i,j] <- sqrt(2-2*sum(unit_dat_aligned_analysis[i,]*unit_dat_aligned_analysis[j,])) 
  }
}
# sum(lower.tri(mat_aligned) - lower.tri(2-2*cor(t(unit_dat_aligned_analysis)))) # <- ==0.
mycorr <- function(x) {
  n <- nrow(x)
  res <- matrix(0,nrow=n,ncol=n)
  for (j in 1:(n-1)){
    for (i in (j+1):n){
      res[i,j] <- sqrt(2-2*sum(x[i,]*x[j,]))
    }
  }
  res <- res + t(res)
  res <- as.dist(res)
  attr(res, "method") <- "mycorr"
  return(res)
}
# 
# mycorr(unit_dat_aligned_analysis)

rownames(mat_aligned) <- colnames(mat_aligned) <- curr_serum_names
rownames(unit_dat_aligned_analysis) <- curr_serum_names
#rownames(mat_aligned) <- colnames(mat_aligned) <- c(make_lane_name(analysis_id[-5],N_per_gel+1),set5_names)#make_lane_name(analysis_id,N_per_gel+1)
#rownames(unit_dat_aligned_analysis) <-c(make_lane_name(analysis_id[-5],N_per_gel+1),set5_names)

if (REPLICATE==TRUE & length(analysis_id)==2){
  rownames(mat_aligned) <- colnames(mat_aligned) <- paste("Pair.",rep(1:20,2),sep="")
  rownames(unit_dat_aligned_analysis)            <- paste("Pair.",rep(1:20,2),sep="")
}


dist_mat_aligned <- as.dist(mat_aligned)

#attr(dist_mat_aligned,"rownames") <- rownames(dat_aligned_analysis)
res_aligned <- hclust(dist_mat_aligned,method="complete")
plot(res_aligned)

# test cosine:
# cosine <- function(x) {
# x <- as.matrix(x)
# y <- t(x) %*% x
# res <- 1 - y / (sqrt(diag(y)) %*% t(sqrt(diag(y))))
# #res <- as.dist(res)
# #attr(res, "method") <- "cosine"
# return(res)
# }
# temp_dist_mat <- cosine(t(unit_dat_aligned_analysis))
# rownames(temp_dist_mat) <- colnames(temp_dist_mat) <- make_lane_name(analysis_id,N_per_gel+1)
# temp_res_aligned <- hclust(as.dist(temp_dist_mat),method="complete")
# plot(temp_res_aligned)


dd_aligned <- dendrapply(as.dendrogram(res_aligned), colorLeafs)
plot(dd_aligned)

#dd_col_branch <- dendextend::color_branches(dd,col = cols[ty[(order.dendrogram(dd))]])
dd_aligned_col_branch <- dendextend::color_branches(dd_aligned,k=10)#, col = c(cols[1],cols[3],cols[2],"gray","orange","maroon","#d6b3b3","#7140b7"))


myplot <- function(){
  par(mar=c(4, 1, 1, 10))
  image(matrix(rnorm(length(t_grid)*2)*0,ncol=2,nrow=length(t_grid)),#type="h",
        main="",
        col="white",
        xlab="",
        cex.lab=2,
        axes=FALSE)
  mtext(ref_wt,at = sapply(ref_loc,function(x) which.min(abs(x-t_grid)))/length(t_grid),side = 3,line=1,cex=0.65)
  mtext("Molecular Weight (kDa)",side = 3,line=-2,cex=2)
}

# visualize heatmap:
pdf(paste0("aligned_subset_signature_result_",paste0("dewarp_",paste(analysis_id,collapse="_")),".pdf"),height=30,width=10)
aligned_signature_figure <- gplots::heatmap.2(dat_aligned_analysis,col=hmcols,
                                            labRow=rownames(dat_aligned_analysis),
                                            labCol= NA,
                                            breaks = 257,srtCol = 0,
                                            RowSideCol=cols[ty],
                                            distfun = mycorr,
                                            scale="none",
                                            Rowv = dd_aligned_col_branch,
                                            dendrogram ="row",
                                            #Rowv = as.dendrogram(row_res),
                                            Colv=NA,
                                            cexRow = 1,
                                            colCol = rep("white",L),
                                            #labCol = NULL,
                                            #xlab="Samples",
                                            ylab="Serum Sample",
                                            margins=c(1.5,10),
                                            colRow = cols[ty],
                                            trace="none",
                                            key=FALSE,
                                            lmat = rbind(c(0,0,4), c(3,1,2),c(5,6,6)),
                                            lhei = c(.5, 6,2),
                                            lwid = c(1.5,0.1,5),
                                            extrafun = myplot)
dev.off()


aligned_leaf_order <- order.dendrogram(dd_aligned_col_branch)
aligned_lane1_index <- sapply(lane1_number,function(s) which(aligned_leaf_order==s))

inserted_lane1 <- matrix(NA,nrow=sum(N_g_vec[analysis_id]),ncol=L+2)
inserted_lane1[lane1_number,] <- 0
inserted_lane1[-lane1_number,] <- data_lcm_all

pdf(paste0("binary_aligned_subset_signature_result",paste0("dewarp_",paste(analysis_id,collapse="_")),".pdf"),height=30,width=10)
par(mar=c(2,3,3,9),xpd=TRUE)
image(v_landmark,1:curr_N_all,t(data_lcm_all[aligned_leaf_order,]),col=hmcols,
      ylab="lane number",xaxt="n",bty="n",yaxt="n")
text(rep((loc_weight_in_lane1-mean(dat_for_dewarp$Y))/sd(dat_for_dewarp$Y),10),
     seq(1,curr_N_all,length=10)+0.5,labels = rev(ref_wt),cex=0.8,col="dodgerblue2")
text(max(v_landmark)+0.5,(1:curr_N_all),rownames(mat_aligned)[aligned_leaf_order],cex=0.8,
     col=cols[ty[aligned_leaf_order]])
# image(v_landmark,1:sum(N_g_vec[analysis_id]),t(inserted_lane1[aligned_leaf_order,]),col=hmcols,
#       ylab="lane number",xaxt="n",bty="n",yaxt="n")
# text(rep((loc_weight_in_lane1-mean(dat_for_dewarp$Y))/sd(dat_for_dewarp$Y),10),
#      seq(1,sum(N_g_vec[analysis_id]),length=10)+0.5,labels = rev(ref_wt),cex=0.8,col="dodgerblue2")
# text(max(v_landmark)+0.5,(1:sum(N_g_vec[analysis_id])),rownames(mat_aligned)[aligned_leaf_order],cex=0.8,
#      col=cols[ty[aligned_leaf_order]])
dev.off()


#
# Naive analysis without preprocessing (but with standardization): 
# It can be used as a crude initialization of the clustering in the matrix factorization model.
#

dat_naive_analysis <- dat_binned_list[[analysis_id[1]]][,-c(1:3)]
for (s in 2:length(analysis_id)){
  dat_naive_analysis <-cbind(dat_naive_analysis, dat_binned_list[[analysis_id[s]]][,-c(1:3)])
}

colnames(dat_naive_analysis) <- curr_serum_names
#colnames(dat_naive_analysis) <- c(make_lane_name(analysis_id[-5],N_per_gel+1),set5_names)# make_lane_name(analysis_id,N_per_gel+1)

dat_naive_analysis <- t(dat_naive_analysis)

#dist_mat_naive <- MKmisc::corDist(dat_naive_analysis,method="pearson") # "kendall", "spearman"

unit_dat_naive_analysis <- mynormalize(dat_naive_analysis)
mat_naive <- matrix(NA,nrow=curr_N_all,ncol = curr_N_all)
for (j in 1:(curr_N_all-1)){
  for (i in (j+1):curr_N_all){
    mat_naive[i,j] <- sqrt(2-2*sum(unit_dat_naive_analysis[i,]*unit_dat_naive_analysis[j,]))
  }
}

rownames(mat_naive) <- colnames(mat_naive) <- curr_serum_names
rownames(unit_dat_naive_analysis) <- curr_serum_names
#rownames(mat_naive) <- colnames(mat_naive) <- c(make_lane_name(analysis_id[-5],N_per_gel+1),set5_names)#make_lane_name(analysis_id,N_per_gel+1)
#rownames(unit_dat_naive_analysis)<- c(make_lane_name(analysis_id[-5],N_per_gel+1),set5_names)#make_lane_name(analysis_id,N_per_gel+1)


if (REPLICATE==TRUE & length(analysis_id)==2){
  rownames(mat_naive) <- colnames(mat_naive) <- paste("Pair.",rep(1:20,2),sep="")
  rownames(unit_dat_aligned_analysis)        <- paste("Pair.",rep(1:20,2),sep="")
}


dist_mat_naive <- as.dist(mat_naive)

#attr(dist_mat_naive,"rownames") <- c(make_lane_name(1,20),make_lane_name(2,20),
#                                     make_lane_name(3,20),make_lane_name(4,20))
res_naive <- hclust(dist_mat_naive,method="complete")
#plot(res_naive)

dd_naive <- dendrapply(as.dendrogram(res_naive), colorLeafs)
plot(dd_naive)
#dd_col_branch <- dendextend::color_branches(dd,col = cols[ty[(order.dendrogram(dd))]])
dd_naive_col_branch <- dendextend::color_branches(dd_naive,k=10)#, col = c(cols[1],cols[3],cols[2],"gray","orange","maroon","#d6b3b3","#7140b7"))

# visualize heatmap for the naive analysis:
pdf(paste0("naive_subset_signature_result_",paste0("dewarp_",paste(analysis_id,collapse="_")),".pdf"),height=30,width=10)
naive_signature_figure <- gplots::heatmap.2(dat_naive_analysis,col=hmcols,
                                            labRow=rownames(dat_naive_analysis),
                                            labCol= NA,
                                            breaks = 257,srtCol = 0,
                                            RowSideCol=cols[ty],
                                            scale="none",
                                            Rowv = dd_naive_col_branch,
                                            dendrogram ="row",
                                            #Rowv = as.dendrogram(row_res),
                                            Colv=NA,
                                            cexRow = 1,
                                            colCol = rep("white",L),
                                            #labCol = NULL,
                                            #xlab="Samples",
                                            ylab="Serum Sample",
                                            margins=c(1.5,10),
                                            colRow = cols[ty],
                                            trace="none",
                                            key=FALSE,
                                            lmat = rbind(c(0,0,4), c(3,1,2),c(5,6,6)),
                                            lhei = c(.5, 6,2),
                                            lwid = c(1.5,0.1,5),
                                            extrafun = myplot)

dev.off()
























#
# JUNKS BELOW!
#








# 
# #
# # Boostrapping the dendrogram:
# #
# cosine <- function(x) {
#   x <- as.matrix(x)
#   y <- t(x) %*% x
#   res <- 2*(1 - y / (sqrt(diag(y)) %*% t(sqrt(diag(y)))))
#   res <- as.dist(res)
#   attr(res, "method") <- "cosine"
#   return(res)
# }
# 
# myboot <- function(x,...){
#   pvclust::pvclust(x, method.hclust="complete", method.dist = cosine,...)
# }
# 
# # rownames(unit_dat_naive_analysis)<- c(make_lane_name(analysis_id[-5],N_per_gel+1),set5_names)
# # rownames(unit_dat_aligned_analysis) <-c(make_lane_name(analysis_id[-5],N_per_gel+1),set5_names)
# 
# #
# # Boostrapping the dendrogram:
# #
# #detach("package:pvclust", unload=TRUE)
# 
# boot_aligned <- myboot(t(unit_dat_aligned_analysis),nboot=2000, parallel=TRUE)
# boot_naive   <- myboot(t(unit_dat_naive_analysis),nboot=2000, parallel=TRUE)
# 
# pdf(paste0("bootstrap_analysis_id_",paste(analysis_id,collapse="_"),".pdf"),height=10,width=14)
# par(mfrow=c(2,1))
# par(oma=c(0,0,0,0),mar=c(1,5,1,1))
# plot(boot_aligned,main="With Processing",col.pv=c("red","white","blue"))
# pvclust::pvrect(boot_aligned,alpha=0.95,max.only=FALSE)
# par(mar=c(1,5,1,1))
# plot(boot_naive,main="No Proprocessing",col.pv=c("red","white","blue"))
# pvclust::pvrect(boot_naive,alpha=0.95,max.only=FALSE)
# dev.off()
# 
# pdf("naive_heatmap_before_dewarping.pdf",height=4*length(analysis_id),width=8)
# par(mfrow=c(length(analysis_id),1))
# #ref_index_list                   <- vector("list",length(analysis_id))
# for (s in seq_along(analysis_id)){
#   g <- analysis_id[s]
#   curr_n_lanes <- attributes(dat_binned_list[[g]])$n_lanes
#   #ref_index_list[[s]] <- vector("list",curr_n_lanes) # <-- need to change 19 to the no. of lanes.
#   par(mar=c(0,2,0,2))
#   image(as.matrix(dat_binned_list[[g]][,-c(1:2)]),col=rev(grey(seq(0,1,length=256))))
# }
# dev.off()
# 
# 
# if (REPLICATE == TRUE){
#   # compare two clusterings:
#   #cutreeDynamicTree(res_aligned,minModuleSize = 2)
#   agreement_aligned_list <- agreement_naive_list <- list()
#   #k_seq <- 2:60
#   k_seq <- 2:20
#   for (k in k_seq){
#     agreement_aligned_list[[k]] <- myARI(cutree(res_aligned,k),c(1:20,1:20))
#     agreement_naive_list[[k]]   <- myARI(cutree(res_naive,k),c(1:20,1:20))
#     # agreement_aligned_list[[k]] <- myARI(cutree(res_aligned,k),c(1:20,1:20,21:40,21:40))
#     # agreement_naive_list[[k]]   <- myARI(cutree(res_naive,k),c(1:20,1:20,21:40,21:40))
#   }
#   
#   pdf("compare_metrics.pdf",height=10,width=10)
#   par(mfrow=c(3,2))
#   plot(k_seq,unlist(lapply(agreement_aligned_list,"[[","ARI")),type="l")
#   points(k_seq,unlist(lapply(agreement_naive_list,"[[","ARI")),type="l",col="red",lty=2)
#   mtext("adjusted Rand Index",3)
#   
#   plot(k_seq,unlist(lapply(agreement_aligned_list,"[[","RI")),type="l")
#   points(k_seq,unlist(lapply(agreement_naive_list,"[[","RI")),type="l",col="red",lty=2)
#   mtext(" Rand Index",3)
#   
#   plot(k_seq,unlist(lapply(agreement_aligned_list,"[[","sensitivity")),type="l")
#   points(k_seq,unlist(lapply(agreement_naive_list,"[[","sensitivity")),type="l",col="red",lty=2)
#   mtext("sensitivity",3)
#   
#   plot(k_seq,unlist(lapply(agreement_aligned_list,"[[","specificity")),type="l")
#   points(k_seq,unlist(lapply(agreement_naive_list,"[[","specificity")),type="l",col="red",lty=2)
#   mtext("specificity",3)
#   
#   plot(k_seq,unlist(lapply(agreement_aligned_list,"[[","VI")),type="l")
#   points(k_seq,unlist(lapply(agreement_naive_list,"[[","VI")),type="l",col="red",lty=2)
#   mtext("VI",3)
#   
#   plot(1-unlist(lapply(agreement_aligned_list,"[[","specificity")),
#        unlist(lapply(agreement_aligned_list,"[[","sensitivity")),type="l",xlim=c(0,1),ylim=c(0,1))
#   points(1-unlist(lapply(agreement_naive_list,"[[","specificity")), unlist(lapply(agreement_naive_list,"[[","sensitivity")),type="l",col="red",lty=2)
#   mtext("AUC",3)
#   dev.off()
#   
#   # # plot aligned versus non-aligned pairs of lanes:
#   # 4 gels:
#   # pdf("compare_lane_alignment.pdf",width=10,height=10)
#   # if (length(analysis_id)%%2 != 0  ){warning("==[spotgear]Not replicate!==")}
#   # for (r in 1:(length(analysis_id)/2)){ # must be replicates!!
#   #   for (l in 1:(1+N_per_gel[2*r-1])){
#   #     par(mfrow=c(2,1))
#   #     matplot(t_grid,t(dat_aligned_analysis[c(0,40)[r]+c(l,l+20),]),type="l",ylab="intensity",xlab="weight")
#   #     mtext(paste0("Lane ",l," (Top: aligned; Bottom: naive)"))
#   #     if (l >=2 ){
#   #       abline(v=t_grid[ref_index_list[[2*r-1]][[l-1]]],col="grey")
#   #       abline(v=t_grid[ref_index_list[[2*r]][[l-1]]],col="grey",lty=2,lwd=2)
#   #     }
#   #     matplot(t_grid,t(dat_naive_analysis[c(0,40)[r]+c(l,l+20),]),type="l",ylab="intensity",xlab="weight")
#   #     abline(v=t_grid[!is.na(score_mat_peak_list[[analysis_id[2*r-1]]][,l])],col="grey")
#   #     abline(v=t_grid[!is.na(score_mat_peak_list[[analysis_id[2*r]]][,l])],col="grey",lty=2,lwd=2)
#   #   }
#   # }
#   
#   # 2 gels:
#   pdf("compare_lane_alignment.pdf",width=10,height=10)
#   if (length(analysis_id)%%2 != 0  ){warning("==[spotgear]Not replicate!==")}
#   for (r in 1:(length(analysis_id)/2)){ # must be replicates!!
#     for (l in 1:(1+N_per_gel[2*r-1])){
#       par(mfrow=c(2,1))
#       matplot(t_grid,t(dat_aligned_analysis[c(0,20)[r]+c(l,l+20),]),type="l",ylab="intensity",xlab="weight")
#       mtext(paste0("Lane ",l," (Top: aligned; Bottom: naive)"))
#       if (l >=2 ){
#         abline(v=t_grid[ref_index_list[[2*r-1]][[l-1]]],col="grey")
#         abline(v=t_grid[ref_index_list[[2*r]][[l-1]]],col="grey",lty=2,lwd=2)
#       }
#       matplot(t_grid,t(dat_naive_analysis[c(0,20)[r]+c(l,l+20),]),type="l",ylab="intensity",xlab="weight")
#       abline(v=t_grid[!is.na(score_mat_peak_list[[analysis_id[2*r-1]]][,l])],col="grey")
#       abline(v=t_grid[!is.na(score_mat_peak_list[[analysis_id[2*r]]][,l])],col="grey",lty=2,lwd=2)
#     }
#   }
#   
#   dev.off()
#   
#   # boostrap ARI :
#   
#   agreement_aligned_boot_list <- agreement_naive_boot_list <- list()
#   res_aligned_boot_list      <- res_naive_boot_list <- list()
#   sil_seq_aligned_boot_list <- sil_seq_naive_boot_list <- list() 
#   for (iter_boot in 1:1000){
#     #smpl <- sample(1:sum(N_g_vec[analysis_id]), sum(N_g_vec[analysis_id]), replace=TRUE)
#     n <- sum(N_g_vec[analysis_id])
#     unique_n <- n/2 # <- divided by 2, just replicates.
#     smpl <- rep(sample(1:unique_n, unique_n, replace = TRUE),2)+rep(c(0,unique_n),each=unique_n)
#     
#     res_aligned_boot_list[[iter_boot]] <- hclust(as.dist(as.matrix(dist_mat_aligned)[smpl,smpl]),method="complete")
#     res_naive_boot_list[[iter_boot]]   <- hclust(as.dist(as.matrix(dist_mat_naive)[smpl,smpl]),method="complete")
#     
#     k_seq <- 1:20
#     agreement_aligned_boot_list[[iter_boot]] <- rep(0,length = length(k_seq))
#     agreement_naive_boot_list[[iter_boot]] <- rep(0,length = length(k_seq))
#     for (k in k_seq){
#       agreement_aligned_boot_list[[iter_boot]][k] <- myARI(cutree(res_aligned_boot_list[[iter_boot]],k),as.numeric(as.factor(smpl - rep(c(0,unique_n),each=unique_n))))$ARI
#       agreement_naive_boot_list[[iter_boot]][k]   <- myARI(cutree(res_naive_boot_list[[iter_boot]],k),as.numeric(as.factor(smpl - rep(c(0,unique_n),each=unique_n))))$ARI
#       # agreement_aligned_list[[k]] <- myARI(cutree(res_aligned,k),c(1:20,1:20,21:40,21:40))
#       # agreement_naive_list[[k]]   <- myARI(cutree(res_naive,k),c(1:20,1:20,21:40,21:40))
#     }
#     
#     
#     # # compare mean silhouette:
#     # kseq <- 2:30
#     # sil_seq_aligned_boot_list[[iter_boot]] <- sil_seq_naive_boot_list[[iter_boot]] <- matrix(NA,nrow=curr_N_all,ncol=length(kseq))
#     # for (i in seq_along(kseq)){
#     #   kgrp <- kseq[i]
#     #   si_aligned <- cluster::silhouette(cutree(res_aligned_boot_list[[iter_boot]],k=kgrp),as.dist(as.matrix(dist_mat_aligned)[smpl,smpl]),nmax.lab=100)
#     #   si_naive   <- cluster::silhouette(cutree(res_naive_boot_list[[iter_boot]],k=kgrp),as.dist(as.matrix(dist_mat_naive)[smpl,smpl]))
#     #   sil_seq_aligned_boot_list[[iter_boot]][,i] <- (si_aligned[,3])
#     #   sil_seq_naive_boot_list[[iter_boot]][,i]   <- (si_naive[,3])
#     # }
#   }
#   
#   pdf("ARI_with_uncertainty.pdf",width=8,height=6)
#   upper_naive <- apply(do.call(rbind,agreement_naive_boot_list),2,quantile,c(0.975))
#   lower_naive <- apply(do.call(rbind,agreement_naive_boot_list),2,quantile,c(0.025))
#   mean_naive <- apply(do.call(rbind,agreement_naive_boot_list),2,mean)
#   
#   plot(k_seq,mean_naive,type="l",lwd=2,ylim=c(0,1),col="red",lty=2,
#        xlab="Number of clusters", ylab="Adjusted Rand Index",cex.lab=1.5)
#   polygon(c(rev(k_seq), k_seq), c(rev(lower_naive), upper_naive), border = NA,col=rgb(1, 0, 0,0.2),lty=2)
#   points(k_seq,mean_naive,type="l",lwd=2,col="red",lty=2)
#   legend("topleft",c("Preprocessed","No proprocessing"),lty=c(1,2),col=c(1,2),lwd=2,bty="n")
#   
#   upper_aligned <- apply(do.call(rbind,agreement_aligned_boot_list),2,quantile,c(0.975))
#   lower_aligned <- apply(do.call(rbind,agreement_aligned_boot_list),2,quantile,c(0.025))
#   mean_aligned <- apply(do.call(rbind,agreement_aligned_boot_list),2,mean)
#   
#   points(k_seq,mean_aligned,type="l",lwd=2,ylim=c(0,1))
#   polygon(c(rev(k_seq), k_seq), c(rev(lower_aligned), upper_aligned), col =rgb(0, 0, 1,0.2), border = NA)
#   points(k_seq,mean_aligned,type="l",lwd=2)
#   
#   dev.off()
# }
# 
# bootstrap_ARI_aligned <- rbind(upper_aligned,mean_aligned,lower_aligned)
# bootstrap_ARI_naive <- rbind(upper_naive,mean_naive,lower_naive)
# 
# 
# # compare mean silhouette:
# kseq <- 3:30
# sil_seq_aligned <- sil_seq_naive <- matrix(NA,nrow=curr_N_all,ncol=length(kseq))
# pdf(paste0("many_sihouette_comparisons_for_no_of_cluster.pdf"),height=6,width=8)
# for (i in seq_along(kseq)){
#   kgrp <- kseq[i]
#   par(mfrow=c(1,2))
#   si_aligned <- cluster::silhouette(cutree(res_aligned,k=kgrp),dist_mat_aligned,nmax.lab=100)
#   plot(si_aligned,main="Proposed")
#   si_naive <- cluster::silhouette(cutree(res_naive,k=kgrp),dist_mat_naive)
#   plot(si_naive,main="Naive")
#   sil_seq_aligned[,i] <- (si_aligned[,3])
#   sil_seq_naive[,i] <- (si_naive[,3])
# }
# dev.off()
# 
# pdf("quantiles_silhouette_comparison.pdf",height=6,width=8)
# # matplot(kseq,t(apply(sil_seq_aligned,2,quantile,c(0.05,0.95))),pch="-",type="l",
# #         lty=1,col="black",xlab = "Number of clusters n",ylab="Silhouette",ylim=c(-0.1,0.7))
# # matplot(kseq,t(apply(sil_seq_naive,2,quantile,c(0.05,0.95))),pch="-",type="l",
# #         col="red",lty=2,add=TRUE)
# # points(kseq, colMeans(sil_seq_aligned), type = "l", pch = 19,col="black",lwd=2)
# # points(kseq, colMeans(sil_seq_naive), type = "l", pch = 19,col="red",lwd=2,lty=2)
# 
# plot(kseq,colMeans(sil_seq_aligned),type="l",lwd=2,ylim=c(0,1),col="black",lty=1,
#      xlab="Number of clusters", ylab="Silhouette",cex.lab=1.5)
# polygon(c(rev(kseq), kseq), c(rev(t(apply(sil_seq_aligned,2,quantile,c(0.05,0.95)))[,1]), 
#                               t(apply(sil_seq_aligned,2,quantile,c(0.05,0.95)))[,2]), border = NA,col=rgb(0, 0, 1,0.2),lty=2)
# 
# points(kseq,colMeans(sil_seq_naive),type="l",lwd=2,col="red",lty=2)
# polygon(c(rev(kseq), kseq), c(rev(t(apply(sil_seq_naive,2,quantile,c(0.05,0.95)))[,1]), 
#                               t(apply(sil_seq_naive,2,quantile,c(0.05,0.95)))[,2]), border = NA,col=rgb(1, 0, 0,0.2),lty=2)
# 
# legend("topleft",c("Preprocessed","No proprocessing"),lty=c(1,2),col=c(1,2),lwd=2,bty="n")
# dev.off()
# 
# sil_percent_change <- round((colMeans(sil_seq_aligned)-colMeans(sil_seq_naive))/colMeans(sil_seq_naive),3)*100
# 
# pdf("quantile_comparisons_aligned_upon_naive.pdf",width=10,height=10)
# par(mfrow=c(5,5))
# for (k in seq_along(kseq)){
#   qqplot(x=sil_seq_naive[,k],y = sil_seq_aligned[,k],main=k+1)
#   qqline(sil_seq_aligned[,k], distribution = function(p) quantile(sil_seq_naive[,k],p),
#          prob = c(0.1, 0.6), col = 2)
# }
# dev.off()
# 
# d = (colMeans(sil_seq_aligned)-colMeans(sil_seq_naive))/colMeans(sil_seq_naive)
# plot(d)
# 
# # # Plot the  average silhouette width
# pdf("average_silhouette_comparison.pdf",height=6,width=8)
# plot(kseq, colMeans(sil_seq_naive), type = "l", pch = 19,
#      frame = FALSE, xlab = "Number of clusters k",col="red",ylim=c(0,1),
#      ylab="Average Silhouette (high value for better separated clusters)")
# points(kseq, colMeans(sil_seq_aligned), type = "l", pch = 19,col="black")
# abline(v = kseq[which.max(colMeans(sil_seq_aligned))], lty = 2)
# legend("topright",c("proposed","naive"),col=c("black","red"),lty=c(1,1),bty="n")
# dev.off()
# 
# # # Compute gap statistic
# # scaled_dat_aligned_analysis <-t(apply(dat_aligned_analysis,1,scale))
# # scaled_dat_naive_analysis   <-t(apply(dat_naive_analysis,1,scale))
# #
# # set.seed(123)
# # gap_stat <- cluster::clusGap(unit_dat_aligned_analysis, FUN = factoextra::hcut, K.max = 30, B = 100)
# # # Plot gap statistic
# # factoextra::fviz_gap_stat(gap_stat)
# #
# # factoextra::fviz_nbclust(scaled_dat_aligned_analysis, factoextra::hcut, method = "wss") +
# #   ggplot2::geom_vline(xintercept = 3, linetype = 2)
# #
# # factoextra::fviz_nbclust(scaled_dat_naive_analysis, factoextra::hcut, method = "wss") +
# #   ggplot2::geom_vline(xintercept = 3, linetype = 2)
# #
# 
# #
# # Euclidea distance after scaling:
# #
# # sil_naive <- factoextra::fviz_nbclust(unit_dat_naive_analysis, factoextra::hcut, 
# #                                       method = "silhouette",
# #                                       hc_method = "complete")
# # sil_aligned <- factoextra::fviz_nbclust(unit_dat_aligned_analysis, factoextra::hcut, 
# #                                         method = "silhouette",
# #                                         hc_method = "complete")
# # 
# # plot(as.numeric(sil_naive$data$clusters), sil_naive$data$y, type = "b", pch = 19, 
# #      frame = FALSE, xlab = "Number of clusters k",col="gray",ylim=c(0,1),
# #      ylab="Average Silhouette (high value for better separated clusters)")
# # points(as.numeric(sil_aligned$data$clusters), sil_aligned$data$y, type = "b", pch = 19,col="green")
# # legend("topright",c("proposed","naive"),col=c("green","gray"),lty=c(1,1),bty="n")
# # 
# 
# 
# # interactive plots of the heatmap: for arbitrary zooming in and out of the data:
# # main_heatmap(dat_aligned_analysis, name = "Measles<br>Cases", x_categorical = FALSE,
# #             font = list(size = 8))
# 
# 
# 
# # aa <- as.matrix(dist_mat_aligned) - as.matrix(dist_mat_naive)
# # aa[1:20,21:40]
# # 
# # boxplot(diag(aa[1:20,21:40]))
# # mean(diag(aa[1:20,21:40]))
# # quantile(diag(aa[1:20,21:40]),c(0.025,0.975))
# # 
# # vv <- diag(aa[1:20,21:40])
# # percent_vv <- round(vv/diag(as.matrix(dist_mat_naive)[1:20,21:40]),4)
# # median(sort(percent_vv))
# 
# 
