require 'htmlentities'

class Article
  attr_accessor :url, :title, :author, :summary, :description, :articleBody, :articleSection, :datePublished, :publisher, :about
  SHARE_TEXT = "OD4D Platform"

  def slug
    title.parameterize
  end

  def article_content_without_html
    strip_html(article_content)
  end

  def article_content
    content = get_content
    return content[0..499] if content.size > 500 && is_third_party?
    content
  end

  def is_third_party?
    return !@publisher.uri.to_s.include?("od4d") if @publisher.uri
    !@publisher.to_s.include?("od4d") if @publisher
  end

  def share_googleplus
     "https://plusone.google.com/_/+1/confirm?hl=en&url=#{URI.escape(@url.to_s)}"
  end

  def share_twitter
     "https://twitter.com/intent/tweet?url=#{URI.escape(@url.to_s)}&text=#{@title}&via=OD4D"
  end

  def share_facebook
    "https://www.facebook.com/sharer/sharer.php?u=#{URI.escape(@url.to_s)}"
  end

  def get_html_tokenized_about
    return "" if @about.empty?
    html_array = []
    @about.each { |about| html_array.push(wrap_html about) }
    return html_array.join(', ')
  end

  private

  def wrap_html(about)
    "<a href=\"/articles/filter/about/#{about}\"><span class=\"semiboldfont\" property=\"schema:about\">#{about}</span></a>"
  end

  def get_content
    return @summary unless @summary.to_s.empty?
    @description
  end

  def strip_html(str)
    re = /<("[^"]*"|'[^']*'|[^'">])*>/
    str.to_s.gsub!(re, '')
    replace_html_codes(str)
  end

  def replace_html_codes(str)
    HTMLEntities.new.decode(str)
  end

end
