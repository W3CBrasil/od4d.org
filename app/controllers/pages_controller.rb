class PagesController < ApplicationController
  def about
  end
  def terms_and_conditions
  end
  def how_to_create_a_semantic_page
  end
  def how_to_integrate_with_od4d
  end
  def how_to_new
  end
  def glossary
  end
  def index
    @articles = ArticleDAO.new.list_articles_limitted_by(2)
  end
  def cases
  end
end
