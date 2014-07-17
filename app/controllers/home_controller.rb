class HomeController < ApplicationController
  def index
    fuseki = Fuseki.new
    fuseki_parser = FusekiJSONParser.new
    @articles = ArticleDAO.new(fuseki, fuseki_parser).list_articles_limitted_by(2)
  end
end
