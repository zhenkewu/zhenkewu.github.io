//search template diferent from 
function simple_search(result_template,sortfun,jsonfile) {

  SimpleJekyllSearch({
    searchInput: document.getElementById('search-input'),
    resultsContainer: document.getElementById('results-container'),
    json: jsonfile,
    sortMiddleware: sortfun,
    searchResultTemplate: result_template,
    limit: document.getElementById('viewnresults').value,// initial number of results
    fuzzy: false
  })
}
