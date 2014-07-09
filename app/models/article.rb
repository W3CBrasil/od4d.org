class Article
  attr_accessor :url, :title, :author, :summary, :description, :articleSection, :datePublished

  def share_twitter
     "https://twitter.com/intent/tweet?url=#{URI.escape(url)}&text=#{URI.escape(title)}&via=OD4D"
  end

  def share_linkedin
     "http://www.linkedin.com/shareArticle?mini=true&url=#{URI.escape(url)}&title=#{URI.escape(title)}&source=#{URI.escape('OD4D.org')}"
  end

  def share_googleplus
     "https://plusone.google.com/_/+1/confirm?hl=en&url=#{URI.escape(url)}"
  end
end
