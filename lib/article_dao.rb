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

  def find_article(uri)
    articleQuery = "
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
                FILTER (?url = <#{uri}>) .
              } LIMIT 1
    "
    query_data = @fuseki.query(articleQuery)
    response_json = JSON.parse(query_data)
    resource = response_json["results"]["bindings"]
    create_from_hash(resource.first)
  end

  def find_article_by_author(author_name)
    query = "
      PREFIX schema: <http://schema.org/>
      SELECT  ?url ?headline ?datePublished ?author
      WHERE   { ?article a schema:Article .
                OPTIONAL { ?article schema:url    ?url } .
                OPTIONAL { ?article schema:headline ?headline } .
                OPTIONAL { ?article schema:datePublished ?datePublished } .
                OPTIONAL { ?article schema:author ?author } .
                FILTER (?author = '#{author_name}') .
              }
      ORDER BY DESC(?datePublished)
      LIMIT 5
    "
    execute_articles_query(query)
  end

  def list_articles
    load_articles
  end

  def list_articles_limitted_by(record_number)
    load_articles(record_number)
  end

  def create_from_hash(article_hash)
    return if article_hash.nil?
    article = Article.new
    article.url = get_value_from_hash(article_hash, "url")
    article.title = get_value_from_hash(article_hash, "headline")
    publisher_str = get_value_from_hash(article_hash, "publisher")
    article.publisher = @partnerDAO.get_partner(publisher_str) unless article_hash["publisher"].to_s.empty?
    article.description = get_value_from_hash(article_hash, "description")

    # Optional fields
    article.articleSection = get_value_from_hash(article_hash, "articleSection")
    article.articleSection = [article.articleSection] unless article.articleSection.is_a? Array
    article.author = get_value_from_hash(article_hash, "author")
    article.summary = get_value_from_hash(article_hash, "articleBody") if article_hash["articleBody"]
    date_raw = get_value_from_hash(article_hash, "datePublished")
    article.datePublished = get_date(date_raw)
    article
  end

  private

  def get_value_from_hash(hash, key)
    hash[key]["value"] if hash[key]
  end
  
  def load_articles(limit=0)
    final_query = ARTICLE_SELECT_QUERY
    final_query = final_query + " ORDER BY DESC(?datePublished)"
    final_query = final_query + " LIMIT #{limit}" if limit != 0
    execute_articles_query(final_query)
  end

  def get_date(date)
    DateTime.iso8601(date) unless date.nil?
  end

  def execute_articles_query(query)
    query_data = @fuseki.query(query)
    response_json = JSON.parse(query_data)
    resources = response_json["results"]["bindings"]
    articles = []
    resources.each {|article_raw| articles.push(create_from_hash(article_raw))}
    articles
  end

end
