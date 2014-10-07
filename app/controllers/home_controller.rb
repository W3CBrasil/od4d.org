require 'string'
# TODO: remove this require

class HomeController < ApplicationController
  def index
    fuseki = Fuseki.new
    fuseki_parser = FusekiJSONParser.new
    @articles = ArticleDAO.new(fuseki, fuseki_parser, I18n.locale).list_articles_limitted_by(5)
  end

  def change_locale
  	I18n.locale = params[:locale]
  	redirect_to controller: "home", action: "index"
  end
end
