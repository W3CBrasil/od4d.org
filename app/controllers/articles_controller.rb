require 'string'
# TODO: remove this require

class ArticlesController < ApplicationController

  helper_method :share_googleplus, :share_twitter, :share_linkedin
  SHARE_TEXT = "OD4D Network"

  def index
    @articles = ArticleDAO.new(Fuseki.new, FusekiJSONParser.new).list_articles
    @partners = PartnerDAO.new(Fuseki.new, FusekiJSONParser.new).list_partners
  end

  def show
    article_dao = ArticleDAO.new(Fuseki.new, FusekiJSONParser.new)
    @article = article_dao.find_article(params[:uri])
    if @article.nil?
      render :file => 'public/404.html', :status => :not_found, :layout => false
    else
      @author_articles = article_dao.find_article_by_author(@article.author)
    end
  end

  def filter
    @articles = ArticleDAO.new(Fuseki.new, FusekiJSONParser.new).filter_articles(params[:field], params[:term])
    post_section = PostSection.find_by_name(params[:term]) if params[:field] == 'articleSection'
    @description = post_section.description if post_section
  end

  private
    def index_url
      url_for controller: 'articles', action: 'index'
    end

    def share_googleplus
       "https://plusone.google.com/_/+1/confirm?hl=en&url=#{URI.escape(index_url)}"
    end

    def share_twitter
       "https://twitter.com/intent/tweet?url=#{URI.escape(index_url)}&text=#{SHARE_TEXT}&via=OD4D"
    end

    def share_linkedin
       "http://www.linkedin.com/shareArticle?mini=true&url=#{URI.escape(index_url)}&title=#{SHARE_TEXT}&source=#{URI.escape('OD4D.org')}"
    end
end
