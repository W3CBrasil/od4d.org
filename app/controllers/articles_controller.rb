require 'string'
# TODO: remove this require

class ArticlesController < ApplicationController
  def index
    @articles = ArticleDAO.new(Fuseki.new, FusekiJSONParser.new).list_articles
    @partners = PartnerDAO.new(Fuseki.new, FusekiJSONParser.new).list_partners
  end
end
