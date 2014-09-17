class Article
	#articleBody is not used
  attr_accessor :url, :title, :author, :summary, :description, :articleBody, :articleSection, :datePublished, :publisher

  def slug
    title.parameterize
  end

  def article_content
    return @summary unless @summary.to_s.empty?
    @description
  end
end
