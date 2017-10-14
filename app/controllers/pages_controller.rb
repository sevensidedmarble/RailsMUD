class PagesController < ApplicationController
  def home
    render template: 'pages/home'
  end
end

# check this out:
# https://stackoverflow.com/questions/4479233/static-pages-in-ruby-on-rails