require 'fuseki'
require 'json'

class ArticleDAO

  ARTICLE_SELECT_QUERY = '
    PREFIX schema: <http://schema.org/>
    SELECT  ?s ?p ?o
    WHERE   { ?s a schema:Article .
              ?s ?p ?o}'

  def initialize(fuseki, fuseki_json_parser)
    @fuseki = fuseki || Fuseki.new
    @fuseki_json_parser = fuseki_json_parser
  end

  def list_articles
    response_json = @fuseki.query(ARTICLE_SELECT_QUERY)
    resources = @fuseki_json_parser.convert(response_json)
    resources.map { |article_hash| create_from_hash(article_hash) }
  end

  def list_articles_limitted_by(record_number)
    list_articles[0..record_number-1]
  end

  def create_from_hash(article_hash)
    article = Article.new
    article.url = article_hash["url"]
    article.title = article_hash["headline"]
    article.author = article_hash["author"]
    article.summary = article_hash["articleBody"][0..500] if article_hash["articleBody"]
    article.description = article_hash["description"]
    article.articleSection = article_hash["articleSection"]
    article.articleSection = [article.articleSection] unless article.articleSection.is_a? Array
    article.datePublished = get_date(article_hash["datePublished"])
    article
  end

  private
  def get_date(date)
    DateTime.iso8601(date) unless date.nil?
  end

end
