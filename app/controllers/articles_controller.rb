require 'string'
# TODO: remove this require

class ArticlesController < ApplicationController

  helper_method :share_googleplus, :share_twitter, :share_linkedin

  def index
    @articles = ArticleDAO.new(Fuseki.new, FusekiJSONParser.new).list_articles
    @partners = PartnerDAO.new(Fuseki.new, FusekiJSONParser.new).list_partners
  end

  private
	  def index_url
	  	url_for controller: 'articles', action: 'index'
	  end

	  def share_googleplus
	     "https://plusone.google.com/_/+1/confirm?hl=en&url=#{URI.escape(index_url)}"
	  end

	  def share_twitter
	     "https://twitter.com/intent/tweet?url=#{URI.escape(index_url)}&text=#{URI.escape("OD4D Network")}&via=OD4D"
	  end

	  def share_linkedin
	     "http://www.linkedin.com/shareArticle?mini=true&url=#{URI.escape(index_url)}&title=#{"OD4D Network"}&source=#{URI.escape('OD4D.org')}"
	  end
end
