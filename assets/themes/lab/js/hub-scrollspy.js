(function () {
  "use strict";

  var navs = Array.prototype.slice.call(document.querySelectorAll("nav.project-hub-nav"));
  if (!navs.length) return;

  var groups = navs.map(function (nav) {
    var chips = Array.prototype.slice.call(nav.querySelectorAll("a.project-hub-chip"));
    var items = chips.map(function (chip) {
      var href = chip.getAttribute("href") || "";
      var id = href.charAt(0) === "#" ? href.slice(1) : "";
      return { chip: chip, el: id ? document.getElementById(id) : null };
    }).filter(function (item) { return item.el; });
    return { nav: nav, items: items };
  }).filter(function (group) { return group.items.length; });

  if (!groups.length) return;

  function markerLine(nav) {
    return nav.getBoundingClientRect().bottom + 12;
  }

  function setActive() {
    groups.forEach(function (group) {
      var items = group.items;
      var line = markerLine(group.nav);
      var current = null;
      var lastAbove = null;
      items.forEach(function (item) {
        var rect = item.el.getBoundingClientRect();
        if (rect.top <= line) lastAbove = item;
        if (rect.top <= line && rect.bottom > line) current = item;
      });
      if (!current) current = lastAbove || items[0];
      items.forEach(function (item) {
        var on = item === current;
        item.chip.classList.toggle("is-active", on);
        if (on) item.chip.setAttribute("aria-current", "true");
        else item.chip.removeAttribute("aria-current");
        item.el.classList.toggle("is-current", on);
      });
    });
  }

  var ticking = false;
  function onScroll() {
    if (ticking) return;
    ticking = true;
    window.requestAnimationFrame(function () {
      setActive();
      ticking = false;
    });
  }

  window.addEventListener("scroll", onScroll, { passive: true });
  window.addEventListener("resize", onScroll);
  window.addEventListener("hashchange", setActive);
  setActive();
})();
