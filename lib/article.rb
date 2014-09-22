class Article
  #articleBody is not used
  attr_accessor :url, :title, :author, :summary, :description, :articleBody, :articleSection, :datePublished, :publisher

  def slug
    title.parameterize
  end

  def article_content
    content = get_content
    return content[0..499] if content.size > 500 && is_third_party?
    content
  end

  def is_third_party?
    !@publisher.uri.to_s.include?("od4d")
  end

  private 

  def get_content
    return @summary unless @summary.to_s.empty?
    @description
  end
end
