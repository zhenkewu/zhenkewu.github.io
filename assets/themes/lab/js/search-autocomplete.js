(function (window) {
  "use strict";

  var STOP = {
    a: 1, an: 1, and: 1, are: 1, as: 1, at: 1, be: 1, by: 1, for: 1, from: 1,
    in: 1, into: 1, is: 1, of: 1, on: 1, or: 1, the: 1, to: 1, via: 1, with: 1,
    using: 1, based: 1, this: 1, that: 1, these: 1, those: 1, over: 1, under: 1
  };

  var MIN_CHARS = 1;
  var RECENT_KEY = "zw-search-recent";
  var MAX_RECENT = 6;
  var MAX_TOTAL = 10;

  function escapeHtml(str) {
    return String(str)
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;");
  }

  function highlight(text, query) {
    var raw = String(text || "");
    var q = String(query || "").trim();
    if (!q) return escapeHtml(raw);
    var lower = raw.toLowerCase();
    var needle = q.toLowerCase();
    var i = lower.indexOf(needle);
    if (i < 0) return escapeHtml(raw);
    return (
      escapeHtml(raw.slice(0, i)) +
      "<b>" + escapeHtml(raw.slice(i, i + q.length)) + "</b>" +
      escapeHtml(raw.slice(i + q.length))
    );
  }

  function splitList(value) {
    return String(value || "")
      .split(/[,;|]+/)
      .map(function (part) { return part.replace(/\s+/g, " ").trim(); })
      .filter(function (part) { return part && part !== ">" && part !== "submitted"; });
  }

  function addTerm(map, term, weight) {
    if (!term) return;
    var trimmed = term.replace(/\s+/g, " ").trim();
    if (trimmed.length < 2) return;
    var key = trimmed.toLowerCase();
    if (STOP[key]) return;
    map[key] = {
      text: trimmed,
      weight: (map[key] ? map[key].weight : 0) + (weight || 1)
    };
  }

  function readRecent() {
    try {
      var parsed = JSON.parse(window.localStorage.getItem(RECENT_KEY) || "[]");
      return parsed.filter(function (item) { return typeof item === "string" && item.trim(); });
    } catch (err) {
      return [];
    }
  }

  function writeRecent(query) {
    var q = String(query || "").trim();
    if (q.length < 2) return;
    var next = [q].concat(readRecent().filter(function (item) {
      return item.toLowerCase() !== q.toLowerCase();
    })).slice(0, MAX_RECENT);
    try {
      window.localStorage.setItem(RECENT_KEY, JSON.stringify(next));
    } catch (err) {}
  }

  function buildIndex(records) {
    var terms = {};
    var pages = [];
    (records || []).forEach(function (record) {
      if (!record) return;
      if (record.title) {
        pages.push({
          title: record.title,
          short_title: record.short_title || "",
          description: record.description || "",
          content: record.content || "",
          url: record.url || "",
          year: record.yearpaper || record.year || "",
          journal: record.journal || "",
          funder: record.funder || "",
          category: record.category || "",
          author: record.author || "",
          tags: record.tags || "",
          projects: record.projects || ""
        });
        String(record.title + " " + (record.short_title || "")).split(/[\s:/–—-]+/).forEach(function (word) {
          var clean = word.replace(/[^A-Za-z0-9+]+/g, "");
          if (clean.length >= 4) addTerm(terms, clean, 1);
        });
      }
      if (record.short_title) addTerm(terms, record.short_title, 6);
      splitList(record.tags).forEach(function (tag) { addTerm(terms, tag, 4); });
      splitList(record.projects).forEach(function (project) { addTerm(terms, project, 5); });
      splitList(record.funder).forEach(function (funder) { addTerm(terms, funder, 5); });
      splitList(record.author).forEach(function (author) {
        addTerm(terms, author, 3);
        var bits = author.split(/\s+/);
        if (bits.length) addTerm(terms, bits[bits.length - 1], 2);
      });
      splitList(record.journal).forEach(function (journal) { addTerm(terms, journal, 2); });
      if (record.category) addTerm(terms, record.category, 3);
      if (record.year && /^\d{4}$/.test(String(record.year))) addTerm(terms, String(record.year), 2);
      if (record.yearpaper && /^\d{4}$/.test(String(record.yearpaper))) addTerm(terms, String(record.yearpaper), 2);
    });
    return {
      terms: Object.keys(terms).map(function (key) { return terms[key]; }),
      pages: pages
    };
  }

  function scoreRelevance(text, query) {
    var hay = String(text || "").toLowerCase();
    var q = String(query || "").toLowerCase().trim();
    if (!q || !hay) return -1;
    if (hay === q) return 10000;
    if (hay.indexOf(q) === 0) return 9000 - Math.min(hay.length, 400);

    var parts = hay.split(/[^a-z0-9+]+/);
    var bestWord = -1;
    for (var i = 0; i < parts.length; i++) {
      var word = parts[i];
      if (!word) continue;
      if (word === q) bestWord = Math.max(bestWord, 8600 - i * 8);
      else if (word.indexOf(q) === 0) bestWord = Math.max(bestWord, 8000 - i * 12 - Math.min(word.length, 80));
    }
    if (bestWord > 0) return bestWord;

    var qparts = q.split(/\s+/).filter(Boolean);
    if (qparts.length > 1) {
      var covered = 0;
      var posBonus = 0;
      for (var j = 0; j < qparts.length; j++) {
        var found = -1;
        for (var k = 0; k < parts.length; k++) {
          if (parts[k].indexOf(qparts[j]) === 0) {
            found = k;
            break;
          }
        }
        if (found < 0) {
          for (var m = 0; m < parts.length; m++) {
            if (parts[m].indexOf(qparts[j]) >= 0) {
              found = m + 20;
              break;
            }
          }
        }
        if (found < 0) break;
        covered += 1;
        posBonus += Math.max(0, 20 - found);
      }
      if (covered === qparts.length) return 5500 + covered * 40 + posBonus;
    }

    if (q.length >= 3) {
      var idx = hay.indexOf(q);
      if (idx >= 0) return 2500 - idx - Math.min(hay.length, 200) * 0.15;
    }
    return -1;
  }

  function pageMeta(page) {
    return [page.year, page.funder || page.journal, page.category].filter(function (bit) {
      return bit && bit !== ">" && bit !== "submitted";
    }).slice(0, 2).join(" · ");
  }

  function suggest(index, query) {
    var q = String(query || "").trim();
    if (q.length < MIN_CHARS) return [];

    var rows = [];
    index.terms.forEach(function (term) {
      var score = scoreRelevance(term.text, q);
      if (score < 0) return;
      rows.push({
        kind: "query",
        text: term.text,
        score: score + Math.min(term.weight, 16) * 0.4
      });
    });

    function fieldScore(text, adj) {
      var score = scoreRelevance(text, q);
      return score < 0 ? -1 : score + adj;
    }

    index.pages.forEach(function (page) {
      var score = Math.max(
        fieldScore(page.title, 0),
        fieldScore(page.short_title, 120),
        fieldScore(page.author, -90),
        fieldScore(page.tags, -50),
        fieldScore(page.journal, -30),
        fieldScore(page.funder, 80),
        fieldScore(page.description, -10),
        fieldScore(page.projects, 40),
        fieldScore(page.category, -40),
        fieldScore(page.content, -160)
      );
      if (score < 0) return;
      rows.push({
        kind: "page",
        text: page.short_title || page.title,
        url: page.url,
        meta: pageMeta(page),
        score: score
      });
    });

    rows.sort(function (a, b) {
      if (b.score !== a.score) return b.score - a.score;
      return a.text.length - b.text.length;
    });

    var seen = {};
    var out = [];
    for (var i = 0; i < rows.length && out.length < MAX_TOTAL; i++) {
      var key = rows[i].kind + ":" + rows[i].text.toLowerCase();
      if (seen[key]) continue;
      seen[key] = 1;
      out.push(rows[i]);
    }
    return out;
  }

  function iconFor(kind) {
    if (kind === "recent") return "fa-solid fa-clock-rotate-left";
    if (kind === "page") return "fa-regular fa-file-lines";
    return "fa-solid fa-magnifying-glass";
  }

  window.initSearchAutocomplete = function (opts) {
    var input = opts && opts.input;
    if (!input || input.dataset.autocompleteReady === "1") return;
    input.dataset.autocompleteReady = "1";
    input.setAttribute("autocomplete", "off");
    input.setAttribute("autocorrect", "off");
    input.setAttribute("spellcheck", "false");
    input.setAttribute("role", "combobox");
    input.setAttribute("aria-autocomplete", "list");
    input.setAttribute("aria-expanded", "false");

    var bar = input.closest(".searchBar") || input.parentElement;
    var list = bar.querySelector(".search-suggest");
    if (!list) {
      list = document.createElement("ul");
      list.className = "search-suggest";
      list.setAttribute("role", "listbox");
      list.hidden = true;
      bar.appendChild(list);
    }
    input.setAttribute("aria-controls", "search-suggest");
    list.id = list.id || "search-suggest";

    var index = { terms: [], pages: [] };
    var items = [];
    var active = -1;
    var picking = false;

    function close() {
      list.hidden = true;
      list.innerHTML = "";
      active = -1;
      bar.classList.remove("is-suggesting");
      input.setAttribute("aria-expanded", "false");
    }

    function setActive(next) {
      var nodes = list.querySelectorAll(".search-suggest-item");
      if (!nodes.length) return;
      active = (next + nodes.length) % nodes.length;
      Array.prototype.forEach.call(nodes, function (node, i) {
        node.classList.toggle("is-active", i === active);
      });
      var current = nodes[active];
      if (current && current.scrollIntoView) current.scrollIntoView({ block: "nearest" });
    }

    function choose(item) {
      if (!item) return;
      picking = true;
      if (item.kind === "page" && item.url) {
        writeRecent(item.text);
        window.location.href = item.url;
        return;
      }
      input.value = item.text;
      writeRecent(item.text);
      close();
      var event;
      try {
        event = new Event("input", { bubbles: true });
      } catch (err) {
        event = document.createEvent("Event");
        event.initEvent("input", true, true);
      }
      input.dispatchEvent(event);
      input.focus();
      window.setTimeout(function () { picking = false; }, 0);
    }

    function render(query) {
      if (picking) return;
      items = suggest(index, query);
      if (!items.length) {
        close();
        return;
      }
      list.innerHTML = items.map(function (item, i) {
        var meta = item.meta ? '<span class="search-suggest-meta">' + escapeHtml(item.meta) + "</span>" : "";
        return (
          '<li class="search-suggest-item" role="option" data-index="' + i + '">' +
            '<i class="' + iconFor(item.kind) + '"></i>' +
            '<span class="search-suggest-text">' + highlight(item.text, query) + meta + "</span>" +
          "</li>"
        );
      }).join("");
      list.hidden = false;
      bar.classList.add("is-suggesting");
      input.setAttribute("aria-expanded", "true");
      active = -1;
    }

    function loadJson(url) {
      if (!url) return;
      var xhr = new XMLHttpRequest();
      xhr.open("GET", url, true);
      xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
          try {
            index = buildIndex(JSON.parse(xhr.responseText));
            if (document.activeElement === input) render(input.value);
          } catch (err) {}
        }
      };
      xhr.send();
    }

    input.addEventListener("input", function () {
      if (picking) return;
      render(input.value);
    });

    input.addEventListener("focus", function () {
      if (picking) return;
      render(input.value);
    });

    input.addEventListener("keydown", function (event) {
      if (list.hidden && (event.key === "ArrowDown" || event.key === "ArrowUp")) {
        render(input.value);
      }
      if (event.key === "ArrowDown") {
        event.preventDefault();
        setActive(active + 1);
      } else if (event.key === "ArrowUp") {
        event.preventDefault();
        setActive(active - 1);
      } else if (event.key === "Enter") {
        if (active >= 0 && items[active]) {
          event.preventDefault();
          choose(items[active]);
        } else if (input.value.trim()) {
          writeRecent(input.value.trim());
          close();
        }
      } else if (event.key === "Escape") {
        close();
      }
    });

    list.addEventListener("mousedown", function (event) {
      var row = event.target.closest(".search-suggest-item");
      if (!row) return;
      event.preventDefault();
      choose(items[Number(row.getAttribute("data-index"))]);
    });

    list.addEventListener("mousemove", function (event) {
      var row = event.target.closest(".search-suggest-item");
      if (!row) return;
      setActive(Number(row.getAttribute("data-index")));
    });

    document.addEventListener("click", function (event) {
      if (!bar.contains(event.target)) close();
    });

    loadJson(opts.jsonUrl);
  };
})(window);
