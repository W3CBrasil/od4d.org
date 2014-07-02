class Article
  attr_reader :url, :title, :author, :summary

  def initialize(url, title, author, summary)
    @url = url
    @title = title
    @author = author
    @summary = summary
  end

end
