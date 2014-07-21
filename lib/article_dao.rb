require 'fuseki'
require 'json'

class ArticleDAO

  ARTICLE_SELECT_QUERY = '
    PREFIX schema: <http://schema.org/>
    SELECT  ?s ?p ?o
    WHERE   { ?s a schema:Article .
              ?s ?p ?o}'

  def initialize(fuseki, fusekiJsonParser)
    @fuseki = fuseki || Fuseki.new
    @fusekiJsonParser = fusekiJsonParser
    @partnerDAO = PartnerDAO.new(fuseki, fusekiJsonParser)
  end

  def list_articles
    load_articles.map{|k, v| v}
  end

  def list_articles_limitted_by(record_number)
    list_articles[0..record_number-1]
  end

  def create_from_hash(article_hash)
    article = Article.new
    article.url = article_hash["url"]
    article.title = article_hash["headline"]
    article.author = article_hash["author"]
    article.publisher = @partnerDAO.get_partner(article_hash["publisher"]) unless article_hash["publisher"].to_s.empty?
    article.summary = article_hash["articleBody"] if article_hash["articleBody"]
    article.description = article_hash["description"]
    article.articleSection = article_hash["articleSection"]
    article.articleSection = [article.articleSection] unless article.articleSection.is_a? Array
    article.datePublished = get_date(article_hash["datePublished"])
    article
  end

  private

  def load_articles
    response_json = @fuseki.query(ARTICLE_SELECT_QUERY)
    resources = @fusekiJsonParser.convert(response_json)
    resources.each{|uri, res| resources[uri] = create_from_hash(res)}
    resources
  end

  def get_date(date)
    DateTime.iso8601(date) unless date.nil?
  end

end
