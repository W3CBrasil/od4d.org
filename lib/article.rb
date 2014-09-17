class Article
	#articleBody is not used
  attr_accessor :url, :title, :author, :summary, :description, :articleBody, :articleSection, :datePublished, :publisher

  def slug
    title.parameterize
  end
end
