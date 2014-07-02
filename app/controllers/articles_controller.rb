class ArticlesController < ApplicationController

  def new
  end

  def create
  end

  def show
    @articles = []
    @articles.push(Article.new('http://www.google.com', 'google news', 'google inc', ''))
    @articles.push(Article.new('http://www.bing.com', 'bing news', 'microsoft inc', ''))
    @articles.push(Article.new('http://www.yahoo.com', 'yahoo news', 'yahoo inc', 'asdqwezxcqweasdzxc'))
    @articles.push(Article.new('http://www.facebook.com', 'facebook news', 'facebook inc', ''))
    @articles.push(Article.new('http://www.youtube.com', 'youtube news', 'google inc', 'asdqwezxcqweasdzxc'))
  end

end
