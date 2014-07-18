require 'string'

class ArticlesController < ApplicationController
  def index
    @articles = ArticleDAO.new(Fuseki.new, FusekiJSONParser.new).list_articles
  end
end
