require 'article_dao'

class ArticlesController < ApplicationController
  def index
    @articles = ArticleDAO.new.list_articles
  end
end


