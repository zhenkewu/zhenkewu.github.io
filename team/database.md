---
layout: page
title: "Team Member Database"
navtab: "team"
description: "Sortable, searchable, filterable member database"
---
{% include JB/setup %}

<style>
  .member-db-controls {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    margin: 15px 0;
    align-items: center;
  }

  .member-db-controls input,
  .member-db-controls select {
    padding: 8px 10px;
    min-width: 180px;
    max-width: 100%;
    box-sizing: border-box;
    border: 1px solid #d9d9d9;
    border-radius: 8px;
    background: #fff;
  }

  .member-db-table-wrap {
    overflow-x: auto;
    border: 1px solid #e8e8e8;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
    background: #fff;
  }

  table.member-db {
    width: 100%;
    border-collapse: collapse;
    margin-top: 0;
    table-layout: auto;
  }

  table.member-db th,
  table.member-db td {
    border-bottom: 1px solid #efefef;
    padding: 10px 12px;
    text-align: left;
    vertical-align: top;
    word-break: break-word;
  }

  table.member-db th {
    cursor: pointer;
    background: #f7f9fc;
    user-select: none;
    white-space: nowrap;
    position: sticky;
    top: 0;
    z-index: 1;
    font-weight: 600;
  }

  table.member-db th .sort-hint {
    color: #888;
    font-size: 11px;
    margin-left: 4px;
  }

  table.member-db th:nth-child(1),
  table.member-db td:nth-child(1) {
    white-space: nowrap;
    width: 72px;
  }

  table.member-db th:nth-child(2),
  table.member-db td:nth-child(2) {
    white-space: nowrap;
    width: 88px;
  }

  table.member-db tbody tr:nth-child(even) {
    background: #fcfcfd;
  }

  table.member-db tbody tr:hover {
    background: #f2f7ff;
  }

  table.member-db a {
    color: #1d5fa7;
    text-decoration: none;
  }

  table.member-db a:hover {
    text-decoration: underline;
  }

  .member-db-position-cell {
    display: grid;
    gap: 4px;
  }

  .member-db-position-line {
    line-height: 1.25;
  }

  .member-db-position-line strong {
    font-weight: 600;
  }

  .member-db-note {
    margin-top: 10px;
    color: #666;
    font-size: 13px;
  }

  .member-db-cards {
    display: none;
    margin-top: 10px;
    gap: 10px;
  }

  .member-db-card {
    border: 1px solid #e8e8e8;
    border-radius: 10px;
    background: #fff;
    box-shadow: 0 1px 5px rgba(0, 0, 0, 0.04);
    padding: 10px;
  }

  .member-db-card-title {
    font-size: 15px;
    font-weight: 600;
    margin-bottom: 4px;
  }

  .member-db-card-title a {
    color: #1d5fa7;
    text-decoration: none;
  }

  .member-db-card-title a:hover {
    text-decoration: underline;
  }

  .member-db-card-main {
    font-size: 13px;
    color: #333;
    margin-bottom: 2px;
  }

  .member-db-card-main strong {
    font-weight: 600;
  }

  .member-db-card-details {
    margin-top: 8px;
    font-size: 12px;
  }

  .member-db-card-details summary {
    cursor: pointer;
    color: #1d5fa7;
    font-weight: 600;
    outline: none;
  }

  .member-db-card-details-content {
    margin-top: 8px;
    display: grid;
    gap: 6px;
  }

  .member-db-card-details-content div {
    line-height: 1.35;
  }

  .umich-icon {
    display: inline-block;
    width: 16px;
    height: 16px;
    border-radius: 3px;
    margin-right: 5px;
    vertical-align: middle;
    object-fit: cover;
  }

  @media (max-width: 992px) {
    .member-db-controls input,
    .member-db-controls select {
      min-width: 160px;
      flex: 1 1 220px;
    }

    table.member-db {
      font-size: 13px;
    }
  }

  @media (max-width: 640px) {
    .member-db-controls {
      flex-direction: column;
      align-items: stretch;
    }

    .member-db-controls input,
    .member-db-controls select {
      width: 100%;
      min-width: 0;
      font-size: 11px;
      line-height: 1;
      padding: 0 4px;
      min-height: unset !important;
      height: 1.3em !important;
      max-height: 1.3em !important;
      box-sizing: border-box;
      border-radius: 6px;
      border-width: 1px;
      -webkit-appearance: none;
      appearance: none;
    }

    table.member-db th,
    table.member-db td {
      padding: 6px;
      font-size: 12px;
      line-height: 1.35;
    }

    table.member-db th .sort-hint {
      font-size: 10px;
      margin-left: 2px;
    }

    .member-db-table-wrap {
      display: none;
    }

    .member-db-cards {
      display: grid;
    }

  }

  @media (max-width: 420px) {
    .member-db-controls {
      gap: 6px;
    }

    .member-db-controls input,
    .member-db-controls select {
      font-size: 10px;
      line-height: 1;
      padding: 0 3px;
      min-height: unset !important;
      height: 1.2em !important;
      max-height: 1.2em !important;
      -webkit-appearance: none;
      appearance: none;
    }
  }
</style>

<p>This page includes all current and former members.</p>

<div class="member-db-note" id="member-db-count"></div>

<div class="member-db-controls">
  <input type="text" id="member-search" placeholder="Search name, role, thesis..." />
  <select id="member-filter-alum">
    <option value="">All status</option>
    <option value="true">Alumni only</option>
    <option value="false">Current only</option>
  </select>
  <select id="member-filter-field">
    <option value="">All fields</option>
  </select>
  <select id="member-filter-institution">
    <option value="">All institutions</option>
  </select>
</div>

<div class="member-db-table-wrap">
  <table class="member-db" id="member-db-table">
    <thead>
      <tr>
        <th data-key="first_name" title="Click to sort">First <span class="sort-hint">↕</span></th>
        <th data-key="last_name" title="Click to sort">Last <span class="sort-hint">↕</span></th>
        <th data-key="role" title="Click to sort">Role <span class="sort-hint">↕</span></th>
        <th data-key="field" title="Click to sort">Field <span class="sort-hint">↕</span></th>
        <th data-key="institution" title="Click to sort">Institution <span class="sort-hint">↕</span></th>
        <th data-key="endyear" title="Click to sort">Alumni Yr <span class="sort-hint">↕</span></th>
        <th data-key="first_position" title="Click to sort">Position <span class="sort-hint">↕</span></th>
        <th data-key="thesis_title" title="Click to sort">Thesis (Project if not a thesis) <span class="sort-hint">↕</span></th>
      </tr>
    </thead>
    <tbody></tbody>
  </table>
</div>

<div class="member-db-cards" id="member-db-cards"></div>

<script>
  (function () {
    var members = [
      {% for member in site.categories.team %}
      {
        title: {{ member.title | jsonify }},
        first_name: {{ member.title | split: " " | first | jsonify }},
        last_name: {{ member.title | split: " " | last | jsonify }},
        url: {{ member.url | jsonify }},
        position: {{ member.position | default: "" | jsonify }},
        role: {{ member.role | default: "" | jsonify }},
        field: {{ member.field | default: "" | jsonify }},
        institution: {{ member.institution | default: "" | jsonify }},
        alum: {{ member.alum | jsonify }},
        endyear: {{ member.endyear | default: "" | jsonify }},
        first_position: {{ member.first_position | default: "" | jsonify }},
        current_position: {{ member.current_position | default: "" | jsonify }},
        thesis_title: {{ member.thesis_title | default: "" | jsonify }},
        thesis_url: {{ member.thesis_url | default: "" | jsonify }}
      }{% unless forloop.last %},{% endunless %}
      {% endfor %}
    ];

    var searchInput = document.getElementById("member-search");
    var alumFilter = document.getElementById("member-filter-alum");
    var fieldFilter = document.getElementById("member-filter-field");
    var institutionFilter = document.getElementById("member-filter-institution");
    var table = document.getElementById("member-db-table");
    var tbody = table.querySelector("tbody");
    var cardsNode = document.getElementById("member-db-cards");
    var countNode = document.getElementById("member-db-count");
    var sortKey = "endyear";
    var sortDir = -1;

    function splitMultiValue(value) {
      if (!value) return [];
      if (Array.isArray(value)) {
        return value
          .map(function (v) { return String(v).trim(); })
          .filter(function (v) { return v.length > 0; });
      }
      return String(value)
        .split(/[;,|]/)
        .map(function (v) { return v.trim(); })
        .filter(function (v) { return v.length > 0; });
    }

    function uniqueValues(key) {
      var values = {};
      members.forEach(function (m) {
        if (!m[key]) return;
        if (key === "field") {
          splitMultiValue(m[key]).forEach(function (v) {
            values[v] = true;
          });
        } else {
          values[m[key]] = true;
        }
      });
      return Object.keys(values).sort();
    }

    function fillSelect(select, values) {
      values.forEach(function (value) {
        var option = document.createElement("option");
        option.value = value;
        option.textContent = value;
        select.appendChild(option);
      });
    }

    fillSelect(fieldFilter, uniqueValues("field"));
    fillSelect(institutionFilter, uniqueValues("institution"));
    function filteredMembers() {
      var q = searchInput.value.trim().toLowerCase();
      var alumValue = alumFilter.value;
      var fieldValue = fieldFilter.value;
      var institutionValue = institutionFilter.value;

      return members.filter(function (m) {
        if (alumValue && String(m.alum) !== alumValue) return false;
        if (fieldValue) {
          var memberFields = splitMultiValue(m.field);
          if (memberFields.indexOf(fieldValue) === -1) return false;
        }
        if (institutionValue && m.institution !== institutionValue) return false;

        if (!q) return true;
        var haystack = [
          m.title,
          m.first_name,
          m.last_name,
          m.role,
          m.field,
          m.institution,
          m.endyear,
          m.first_position,
          m.current_position,
          m.thesis_title
        ].join(" ").toLowerCase();
        return haystack.indexOf(q) !== -1;
      });
    }

    function compareValues(a, b) {
      if (sortKey === "endyear") {
        var ay = parseInt(a.endyear, 10);
        var by = parseInt(b.endyear, 10);
        var an = isNaN(ay) ? -Infinity : ay;
        var bn = isNaN(by) ? -Infinity : by;
        if (an < bn) return -1 * sortDir;
        if (an > bn) return 1 * sortDir;
        return 0;
      }

      var av = a[sortKey] == null ? "" : String(a[sortKey]).toLowerCase();
      var bv = b[sortKey] == null ? "" : String(b[sortKey]).toLowerCase();
      if (av < bv) return -1 * sortDir;
      if (av > bv) return 1 * sortDir;
      return 0;
    }

    function render() {
      var rows = filteredMembers().sort(compareValues);
      tbody.innerHTML = "";
      cardsNode.innerHTML = "";

      rows.forEach(function (m) {
        var tr = document.createElement("tr");
        var currentPositionCell = m.current_position || "";
        if (currentPositionCell === (m.first_position || "")) {
          currentPositionCell = "";
        }
        var institutionCell = m.institution
          ? '<img class="umich-icon" src="https://play-lh.googleusercontent.com/VDUtvYtd2tr9sQXulbPv9kJbJHBMJmZG0V05EvGBHmrFWkjK7bWQ9pn5mj8SyFq4nWY" alt="UMich icon" />' + m.institution
          : "";

        var thesisCell = m.thesis_title || "";
        if (m.thesis_url && m.thesis_title) {
          thesisCell = '<a href="' + m.thesis_url + '">' + m.thesis_title + "</a>";
        }
        var positionCell =
          '<div class="member-db-position-cell">' +
          '<div class="member-db-position-line"><strong>First:</strong> ' + (m.first_position || "") + "</div>" +
          '<div class="member-db-position-line"><strong>Current:</strong> ' + (currentPositionCell || "") + "</div>" +
          "</div>";

        tr.innerHTML =
          '<td><a href="' + (m.url || "#") + '">' + (m.first_name || "") + "</a></td>" +
          "<td>" + (m.last_name || "") + "</td>" +
          "<td>" + (m.role || "") + "</td>" +
          "<td>" + splitMultiValue(m.field).join(", ") + "</td>" +
          "<td>" + institutionCell + "</td>" +
          "<td>" + (m.endyear || "") + "</td>" +
          "<td>" + positionCell + "</td>" +
          "<td>" + thesisCell + "</td>";

        tbody.appendChild(tr);

        var card = document.createElement("div");
        card.className = "member-db-card";
        card.innerHTML =
          '<div class="member-db-card-title"><a href="' + (m.url || "#") + '">' + (m.first_name || "") + " " + (m.last_name || "") + "</a></div>" +
          '<div class="member-db-card-main"><strong>Role:</strong> ' + (m.role || "") + "</div>" +
          '<div class="member-db-card-main"><strong>Field:</strong> ' + splitMultiValue(m.field).join(", ") + "</div>" +
          '<div class="member-db-card-main"><strong>Institution:</strong> ' + institutionCell + "</div>" +
          '<div class="member-db-card-main"><strong>Current:</strong> ' + (m.alum ? "No" : "Yes") + "</div>" +
          '<details class="member-db-card-details"><summary>More details</summary>' +
          '<div class="member-db-card-details-content">' +
          "<div><strong>Aluminus Since:</strong> " + (m.endyear || "") + "</div>" +
          "<div><strong>First Position:</strong> " + (m.first_position || "") + "</div>" +
          "<div><strong>Current Position:</strong> " + currentPositionCell + "</div>" +
          "<div><strong>Thesis:</strong> " + thesisCell + "</div>" +
          "</div></details>";
        cardsNode.appendChild(card);
      });

      countNode.textContent = rows.length + " member(s) shown";
    }

    Array.prototype.slice.call(table.querySelectorAll("th[data-key]")).forEach(function (th) {
      th.addEventListener("click", function () {
        var nextKey = th.getAttribute("data-key");
        if (sortKey === nextKey) {
          sortDir = sortDir * -1;
        } else {
          sortKey = nextKey;
          sortDir = 1;
        }
        render();
      });
    });

    [searchInput, alumFilter, fieldFilter, institutionFilter].forEach(function (el) {
      el.addEventListener("input", render);
      el.addEventListener("change", render);
    });

    render();
  })();
</script>
