source 'https://rubygems.org'

# Same Jekyll as local preview. GitHub Actions uses this Gemfile
# instead of the github-pages gem (Jekyll 3).
gem "jekyll", "4.3.2"
gem "kramdown"
gem "webrick"

group :jekyll_plugins do
  gem "jekyll-feed"
  gem "jekyll-redirect-from"
  gem "jekyll-gist"
end

# Local/dev tools only. CI sets BUNDLE_WITHOUT=development.
group :development do
  gem "jekyll-press"
  gem "octokit"
  gem "netrc"
  gem "json"
  gem "pygments.rb"
  gem "rspec"
  gem "jekyll-twitter-plugin"
end
