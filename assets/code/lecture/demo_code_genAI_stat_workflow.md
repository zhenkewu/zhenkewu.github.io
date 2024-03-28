======Demo 1 on Simulation

- Missing data

Please conduct a simulation about the linear regression, and considering various missing mechanism of data (MCAR, MAR, MNAR). In the linear regression, please include both a continuous variable and a binary variable.

Merge and put the code into a script

Please repeat 1000 times and calculate the average width and the coverage rate of confidence intervals.

please implement the code in STAN.

- latent class model

Let's swtich to a new simulation. The primary goal is to simulate data following a latent class model with three classes, each of which has 10 dimensions; generate the response probabilities in each class randomly and indepedently. Use R. Try to fit the latent class model using the simulatd data. Evaluate how close the estimated response probabilities are to the truth in terms of root mean squared errors.

- slide generation (present results):

Can you generate 20 slides to teaching master students linear mixed models at Michgian biostatistics. Use Michgian Biostatistics themed slides.

Co-pilot in RStudio:

https://colorado.posit.co/rsc/rstudio-copilot/#/TitleSlide


=======Demo 2 on document summarization

dissemination. summarize to a level of high school student; word cloud; poster.



======Demo 3

1. SEEO framework

I have one issue with the R code. The following example does not return expected results.

# Example: linear regression

data(cars)
result <- lm(speed~-1+dist,data=cars)
result

# won't match because the result does not include an intercept estimate

Expected:
Coefficients:
(Intercept)         dist  
     8.2839       0.1656  

Returned:
Coefficients:
  dist  
0.3081



2. RAP: act like an associate professor of biostatistics at University of Michigan. How should the person plan the next stage of career for a fullfilling 2030 vision. Put this into an action plan. In particular, provide a table of statistics and data science conferences with a focus on generative AI and biostatistics that this person may attend; the columns should include the date, location, registration fee, URL for the conferences.

3. chain of thought: Use LLM reasoning by stacking multiple questions that lead ChatGPT to the desired response.

Why it works?
Rarely is the 1st response the best. But ChatGPT has memory.

The Nth response can be extremely powerful.


a. start by making a shinyapp that uploads a user excel

b. add a way to visualize the date column (automatically selected) versus a value column from the excel file

c. include some sample data for the user to get started with


Then run the app in RStudio.

4. put the code into a script

5. Error codes framework.


1: There were 15 divergent transitions after warmup.



Demo 4: 

please tell me what is it as detailed as you can in each cell in a tabular format aligned with this picture grid.



