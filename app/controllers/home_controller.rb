class HomeController < ApplicationController
  def index
    @articles = ArticleDAO.new.list_articles_limitted_by(2)
  end
end
