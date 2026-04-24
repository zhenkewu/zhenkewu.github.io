---
layout: default
title: "Software"
navtab: "Software"
description: "Software built by the Wu Lab: practical, research-grade tools for health and data science"
group: subnavigation
navorder: 1
---
{% include JB/setup %}

<div class="smalltitle text-left">Software by the Wu Lab</div>
<div class="bigspacer"></div>

<div class="feedbox pad-left">
  <div class="head">Research-grade software for real-world decisions</div>
  <div class="smallspacer"></div>
  <div class="note">
    Deploy robust statistical and AI methods without sacrificing interpretability or scientific validity.
    These products are designed for high-stakes settings where decisions must be transparent, reproducible, and operationally practical.
  </div>
  <div class="smallspacer"></div>
  <div class="note">
    <a href="/sayhi/"><i class="fa-regular fa-envelope"></i> Share your use case</a>
    &nbsp; | &nbsp;
    <a href="https://github.com/zhenkewu?tab=repositories" target="_blank" rel="noopener"><i class="fa-brands fa-github"></i> Explore all repositories</a>
    &nbsp; | &nbsp;
    <a href="/papers/archive/topic"><i class="fa-regular fa-file-lines"></i> Match methods to publications</a>
  </div>
</div>

<div class="bigspacer"></div>

<div class="smalltitle text-left">Choose by goal</div>
<div class="smallspacer"></div>
<div class="row">
  <div class="col-sm-12 col-md-4">
    <div class="feedbox pad-left">
      <div class="head">Estimate disease burden</div>
      <div class="smallspacer"></div>
      <div class="note">Use latent-variable model software for etiologic inference and population-level burden estimation.</div>
    </div>
  </div>
  <div class="col-sm-12 col-md-4">
    <div class="feedbox pad-left">
      <div class="head">Personalize interventions</div>
      <div class="smallspacer"></div>
      <div class="note">Use reinforcement-learning and decision-focused tools to support adaptive and individualized care.</div>
    </div>
  </div>
  <div class="col-sm-12 col-md-4">
    <div class="feedbox pad-left">
      <div class="head">Validate AI-supported analysis</div>
      <div class="smallspacer"></div>
      <div class="note">Use inference-focused products that remain valid with machine learning predictions or synthetic data.</div>
    </div>
  </div>
</div>

<div class="bigspacer"></div>

<div id="software-products-proof" class="smallnote">Loading product highlights...</div>
<div class="smallspacer"></div>
<div id="software-products-viz"></div>

<div class="bigspacer"></div>
<div class="smalltitle text-left">Why collaborators choose these tools</div>
<div class="smallspacer"></div>
<div class="row">
  <div class="col-sm-12 col-md-4">
    <div class="feedbox pad-left">
      <div class="head">Maintained and active</div>
      <div class="smallspacer"></div>
      <div class="note">Repositories are pulled live from GitHub and prioritized by recent updates to help you find actively maintained options.</div>
    </div>
  </div>
  <div class="col-sm-12 col-md-4">
    <div class="feedbox pad-left">
      <div class="head">Scientifically grounded</div>
      <div class="smallspacer"></div>
      <div class="note">Methods are linked to peer-reviewed work and real deployment settings in global and precision health.</div>
    </div>
  </div>
  <div class="col-sm-12 col-md-4">
    <div class="feedbox pad-left">
      <div class="head">Open to collaboration</div>
      <div class="smallspacer"></div>
      <div class="note">If your team needs adaptation, benchmarking, or deployment support, reach out and we can scope a joint effort.</div>
    </div>
  </div>
</div>

<div class="bigspacer"></div>
<div class="smalltitle text-left">Who this is for</div>
<div class="smallspacer"></div>

<div class="row">
  <div class="col-sm-12 col-md-4">
    <div class="feedbox pad-left">
      <div class="head"><i class="fa-solid fa-user-doctor"></i> Health Researchers</div>
      <div class="smallspacer"></div>
      <div class="note">Need valid analysis under missingness, measurement error, or constrained data settings.</div>
    </div>
  </div>
  <div class="col-sm-12 col-md-4">
    <div class="feedbox pad-left">
      <div class="head"><i class="fa-solid fa-chart-line"></i> Data Scientists</div>
      <div class="smallspacer"></div>
      <div class="note">Need methods that are both statistically principled and production-friendly.</div>
    </div>
  </div>
  <div class="col-sm-12 col-md-4">
    <div class="feedbox pad-left">
      <div class="head"><i class="fa-solid fa-building-columns"></i> Public-Health Teams</div>
      <div class="smallspacer"></div>
      <div class="note">Need transparent tools for high-stakes decisions with reproducibility and policy relevance.</div>
    </div>
  </div>
</div>

<div class="bigspacer"></div>
<div class="smalltitle text-left">Recently Updated Products</div>
<div class="smallspacer"></div>
<div id="software-products-featured"></div>

<div class="bigspacer"></div>
<div class="smalltitle text-left">Adoption paths</div>
<div class="smallspacer"></div>

<div class="row">
  <div class="col-sm-12 col-md-4">
    <div class="feedbox pad-left">
      <div class="head">Quick Trial (10-30 mins)</div>
      <div class="smallspacer"></div>
      <div class="note">Pick a repo, run the examples, and verify whether assumptions match your setting.</div>
    </div>
  </div>
  <div class="col-sm-12 col-md-4">
    <div class="feedbox pad-left">
      <div class="head">Pilot (1-2 weeks)</div>
      <div class="smallspacer"></div>
      <div class="note">Integrate into one workflow, benchmark against your baseline, and document gains.</div>
    </div>
  </div>
  <div class="col-sm-12 col-md-4">
    <div class="feedbox pad-left">
      <div class="head">Deployment Collaboration</div>
      <div class="smallspacer"></div>
      <div class="note">For larger efforts, we can discuss tailored onboarding and methodological alignment.</div>
    </div>
  </div>
</div>

<div class="bigspacer"></div>
<div class="feedbox pad-left">
  <div class="head">Interested in using a product?</div>
  <div class="smallspacer"></div>
  <div class="note">
    Share your problem setting, data structure, and timeline via zhenkewu [arroba] umich [punto] edu.
    If useful, include links to your current pipeline or analysis script so we can recommend the best starting point.
  </div>
</div>

<script>
  (function () {
    var username = "zhenkewu";
    var endpoint = "https://api.github.com/users/" + username + "/repos?per_page=100&sort=updated";
    var featuredLimit = 8;

    function escapeHtml(text) {
      if (!text) return "";
      return text
        .replace(/&/g, "&amp;")
        .replace(/</g, "&lt;")
        .replace(/>/g, "&gt;")
        .replace(/"/g, "&quot;")
        .replace(/'/g, "&#039;");
    }

    function formatDate(value) {
      var dt = new Date(value);
      if (Number.isNaN(dt.getTime())) return "";
      return dt.toLocaleDateString(undefined, { year: "numeric", month: "short", day: "numeric" });
    }

    function repoCard(repo) {
      var description = escapeHtml(repo.description || "No description provided.");
      var language = repo.language ? "<span class='label label-default'>" + escapeHtml(repo.language) + "</span>" : "";
      var stars = "<span class='label label-warning'><i class='fa-solid fa-star'></i> " + repo.stargazers_count + "</span>";
      var forks = "<span class='label label-info'><i class='fa-solid fa-code-fork'></i> " + repo.forks_count + "</span>";
      var homepage = repo.homepage
        ? "<a class='btn btn-xs btn-default' href='" + escapeHtml(repo.homepage) + "' target='_blank' rel='noopener'><i class='fa-solid fa-book-open'></i> Docs</a>"
        : "";
      var issues = "<a class='btn btn-xs btn-default' href='" + repo.html_url + "/issues' target='_blank' rel='noopener'><i class='fa-regular fa-circle-question'></i> Ask / Report</a>";
      var topics = (repo.topics || []).slice(0, 4).map(function (topic) {
        return "<span class='label label-default' style='margin-right:4px;'>" + escapeHtml(topic) + "</span>";
      }).join("");
      return (
        "<div class='feedbox pad-left'>" +
          "<div class='head'><i class='fa-brands fa-github'></i> <a class='off' href='" + repo.html_url + "' target='_blank' rel='noopener'>" + escapeHtml(repo.name) + "</a></div>" +
          "<div class='smallspacer'></div>" +
          "<div class='note'>" + description + "</div>" +
          "<div class='smallspacer'></div>" +
          (topics ? "<div class='smallnote'>" + topics + "</div><div class='smallspacer'></div>" : "") +
          "<div class='smallnote'>" + stars + " " + forks + " " + language + " Updated " + formatDate(repo.updated_at) + "</div>" +
          "<div class='smallspacer'></div>" +
          "<div class='smallnote'>" +
            "<a class='btn btn-xs btn-primary' href='" + repo.html_url + "' target='_blank' rel='noopener'><i class='fa-brands fa-github'></i> View Code</a> " +
            homepage + " " +
            issues + " " +
            "<a class='btn btn-xs btn-success' href='/sayhi/'><i class='fa-regular fa-envelope'></i> Discuss Adoption</a>" +
          "</div>" +
        "</div>" +
        "<div class='spacer'></div>"
      );
    }

    function render(repos) {
      var proofEl = document.getElementById("software-products-proof");
      var vizEl = document.getElementById("software-products-viz");
      var featuredEl = document.getElementById("software-products-featured");

      var nonForkRepos = repos.filter(function (repo) { return !repo.fork; });
      var curated = nonForkRepos
        .sort(function (a, b) { return b.stargazers_count - a.stargazers_count; });
      var recentUpdated = nonForkRepos
        .slice()
        .sort(function (a, b) {
          return new Date(b.updated_at).getTime() - new Date(a.updated_at).getTime();
        })
        .slice(0, featuredLimit);

      if (!curated.length) {
        proofEl.textContent = "No repositories found.";
        vizEl.innerHTML = "";
        featuredEl.innerHTML = "";
        return;
      }

      var totalStars = curated.reduce(function (sum, repo) { return sum + repo.stargazers_count; }, 0);
      var totalForks = curated.reduce(function (sum, repo) { return sum + repo.forks_count; }, 0);
      var recentActive = curated.filter(function (repo) {
        var updatedDays = (Date.now() - new Date(repo.updated_at).getTime()) / (1000 * 60 * 60 * 24);
        return updatedDays <= 180;
      }).length;

      proofEl.innerHTML =
        "<strong>Why trust these products:</strong> " +
        curated.length + " maintained repositories, " +
        totalStars + " stars, " +
        totalForks + " forks, " +
        recentActive + " updated in the last 6 months.";

      var topStarred = curated.slice(0, 5);
      var maxStars = topStarred.length ? Math.max.apply(null, topStarred.map(function (repo) { return repo.stargazers_count; })) : 1;
      var starBars = topStarred.map(function (repo) {
        var width = Math.max(8, Math.round((repo.stargazers_count / (maxStars || 1)) * 100));
        return (
          "<div style='margin-bottom:10px;'>" +
            "<div class='smallnote' style='display:flex;justify-content:space-between;gap:10px;'>" +
              "<span style='overflow:hidden;text-overflow:ellipsis;white-space:nowrap;'>" + escapeHtml(repo.name) + "</span>" +
              "<span>" + repo.stargazers_count + "</span>" +
            "</div>" +
            "<div style='background:#f1f1f1;border-radius:4px;height:10px;'>" +
              "<div style='width:" + width + "%;background:#f0ad4e;height:10px;border-radius:4px;'></div>" +
            "</div>" +
          "</div>"
        );
      }).join("");

      var languageCounts = {};
      curated.forEach(function (repo) {
        var lang = repo.language || "Unknown";
        languageCounts[lang] = (languageCounts[lang] || 0) + 1;
      });
      var topLanguages = Object.keys(languageCounts)
        .map(function (k) { return { name: k, count: languageCounts[k] }; })
        .sort(function (a, b) { return b.count - a.count; })
        .slice(0, 5);
      var maxLang = topLanguages.length ? topLanguages[0].count : 1;
      var langBars = topLanguages.map(function (item) {
        var width = Math.max(8, Math.round((item.count / maxLang) * 100));
        return (
          "<div style='margin-bottom:10px;'>" +
            "<div class='smallnote' style='display:flex;justify-content:space-between;'>" +
              "<span>" + escapeHtml(item.name) + "</span>" +
              "<span>" + item.count + "</span>" +
            "</div>" +
            "<div style='background:#f1f1f1;border-radius:4px;height:10px;'>" +
              "<div style='width:" + width + "%;background:#4a90e2;height:10px;border-radius:4px;'></div>" +
            "</div>" +
          "</div>"
        );
      }).join("");

      vizEl.innerHTML =
        "<div class='row'>" +
          "<div class='col-sm-12 col-md-6'>" +
            "<div class='feedbox pad-left'>" +
              "<div class='smalltitle text-left'>Top Repositories by Stars</div>" +
              "<div class='smallspacer'></div>" +
              starBars +
            "</div>" +
          "</div>" +
          "<div class='col-sm-12 col-md-6'>" +
            "<div class='feedbox pad-left'>" +
              "<div class='smalltitle text-left'>Technology Breadth</div>" +
              "<div class='smallspacer'></div>" +
              langBars +
            "</div>" +
          "</div>" +
        "</div>";

      featuredEl.innerHTML =
        "<div class='smallnote'>Showing the <strong>" + recentUpdated.length + "</strong> most recently updated non-fork repositories.</div>" +
        "<div class='smallspacer'></div>" +
        recentUpdated.map(repoCard).join("");
    }

    function renderError() {
      var proofEl = document.getElementById("software-products-proof");
      var vizEl = document.getElementById("software-products-viz");
      var featuredEl = document.getElementById("software-products-featured");
      proofEl.textContent = "Could not load software products from GitHub right now.";
      vizEl.innerHTML = "";
      featuredEl.innerHTML = "<div class='note'>Please retry later or browse <a href='https://github.com/zhenkewu?tab=repositories' target='_blank' rel='noopener'>all repositories on GitHub</a>.</div>";
    }

    fetch(endpoint, {
      headers: {
        "Accept": "application/vnd.github+json"
      }
    })
      .then(function (response) {
        if (!response.ok) throw new Error("GitHub API request failed");
        return response.json();
      })
      .then(render)
      .catch(renderError);
  })();
</script>
