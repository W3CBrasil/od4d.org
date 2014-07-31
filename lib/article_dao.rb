require 'fuseki'
require 'json'

class ArticleDAO

  ARTICLE_SELECT_QUERY = '
        PREFIX schema: <http://schema.org/>
        SELECT  ?article ?url ?author ?headline ?summary ?description ?articleBody ?articleSection ?datePublished ?publisher
        WHERE   { ?article a schema:Article .
                OPTIONAL { ?article schema:url    ?url } .
                OPTIONAL { ?article schema:author ?author } .
                OPTIONAL { ?article schema:headline ?headline } .
                OPTIONAL { ?article schema:summary  ?summary } .
                OPTIONAL { ?article schema:description ?description } .
                OPTIONAL { ?article schema:articleBody ?articleBody } .
                OPTIONAL { ?article schema:articleSection ?articleSection } .
                OPTIONAL { ?article schema:datePublished ?datePublished } .
                OPTIONAL { ?article schema:publisher ?publisher } .
                }'

  def initialize(fuseki, fusekiJsonParser)
    @fuseki = fuseki || Fuseki.new
    @fusekiJsonParser = fusekiJsonParser
    @partnerDAO = PartnerDAO.new(fuseki, fusekiJsonParser)
  end

  def list_articles
    load_articles
  end

  def list_articles_limitted_by(record_number)
    load_articles(record_number)
  end

  def get_value_from_hash(hash, key)
    hash[key]["value"]
  end

  def create_from_hash(article_hash)
    article = Article.new
    article.url = get_value_from_hash(article_hash, "url")
    article.title = get_value_from_hash(article_hash, "headline")
    article.author = get_value_from_hash(article_hash, "author")
    article.publisher = @partnerDAO.get_partner(get_value_from_hash(article_hash, "publisher")) unless article_hash["publisher"].to_s.empty?
    article.summary = get_value_from_hash(article_hash, "articleBody") if article_hash["articleBody"]
    article.description = get_value_from_hash(article_hash, "description")
    article.articleSection = get_value_from_hash(article_hash, "articleSection")
    article.articleSection = [article.articleSection] unless article.articleSection.is_a? Array
    date_raw = get_value_from_hash(article_hash, "datePublished")
    article.datePublished = get_date(date_raw)
    article
  end

  private

  def load_articles(limit=0)
    final_query = ARTICLE_SELECT_QUERY
    final_query = final_query + " LIMIT #{limit}" if limit != 0
    query_data = @fuseki.query(final_query)
    response_json = JSON.parse(query_data)
    resources = response_json["results"]["bindings"]
    # resources: [articles], article: prop:{type, value}
    articles = []
    resources.each {|article_raw| articles.push(create_from_hash(article_raw))}
    articles
  end

  def get_date(date)
    DateTime.iso8601(date) unless date.nil?
  end

end
