function global_search(selectedValue) {
  SimpleJekyllSearch({
    searchInput: document.getElementById('search-input'),
    resultsContainer: document.getElementById('results-container'),
    json: '/search-global.json',
    sortMiddleware: function (a, b) {
      var astr = String(a.category) + "-" + String(a.year);
      var bstr = String(b.category) + "-" + String(b.year);
      return bstr.localeCompare(astr)
    },
    searchResultTemplate: '<li>[<em>{category}</em>] ({year}) <a href="{url}">{title}</a> {author}</li>',
    limit: selectedValue,// initial number of results
    fuzzy: false
  })
}