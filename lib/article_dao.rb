require 'fuseki'
require 'json'
require "turtle"
require 'resource'

class ArticleDAO

  ARTICLE_SELECT_QUERY = '
    PREFIX schema: <http://schema.org/>
    SELECT  ?article ?url ?author ?headline ?summary ?description ?articleBody ?articleSection ?datePublished ?publisher
    WHERE   { ?article a schema:Article .
            ?article schema:url    ?url .
            ?article schema:author ?author .
            OPTIONAL { ?article schema:headline ?headline } .
            OPTIONAL { ?article schema:summary  ?summary } .
            OPTIONAL { ?article schema:description ?description } .
            OPTIONAL { ?article schema:articleBody ?articleBody } .
            OPTIONAL { ?article schema:articleSection ?articleSection } .
            ?article schema:datePublished ?datePublished .
            ?article schema:publisher ?publisher .
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
                ?article schema:url    ?url .
                ?article schema:author ?author .
                OPTIONAL { ?article schema:headline ?headline } .
                OPTIONAL { ?article schema:summary  ?summary } .
                OPTIONAL { ?article schema:description ?description } .
                OPTIONAL { ?article schema:articleBody ?articleBody } .
                OPTIONAL { ?article schema:articleSection ?articleSection } .
                ?article schema:datePublished ?datePublished .
                ?article schema:publisher ?publisher .
                FILTER (?url = <#{uri}>) .
              } LIMIT 1"
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
                ?article schema:url    ?url .
                ?article schema:headline ?headline .
                ?article schema:datePublished ?datePublished .
                ?article schema:author ?author .
                FILTER (?author = '#{author_name}') .
              }
      ORDER BY DESC(?datePublished)
      LIMIT 5"
    execute_articles_query(query)
  end

  def insert(article)
    turtle_prefixes = {
      rdf: 'http://www.w3.org/1999/02/22-rdf-syntax-ns#',
      schema: 'http://schema.org/'
    }
    res = Resource.new("http://www.od4d.br/posts/#{article["id"]}", "Article")
    add_optional_to_resource(res, "headline", article["title"])
    add_optional_to_resource(res, "url", "http://www.od4d.br/posts/#{article["id"]}")
    add_optional_to_resource(res, "description", article["content"][0..499])
    add_optional_to_resource(res, "author", article["author"])
    add_optional_to_resource(res, "datePublished", (article["pub_date"].iso8601() unless article["pub_date"].nil?))
    add_optional_to_resource(res, "articleBody", article["content"])
    add_optional_to_resource(res, "publisher", "http://www.od4d.br/")
    add_optional_to_resource(res, "about", article["about"].split(','))
    turtle = Turtle.new(turtle_prefixes)
    turtle.add_resource(res)
    @fuseki.insert(turtle.to_s)
  end

  def add_optional_to_resource(res, field_name, field_value)
    res.add_property(field_name, field_value) unless field_value.to_s.empty?
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
    article.about = get_value_from_hash(article_hash, "about")
    date_raw = get_value_from_hash(article_hash, "datePublished")
    article.datePublished = get_date(date_raw)
    article.about = find_about_by_article_uri(article.url)
    article
  end

  private

  def find_about_by_article_uri(uri)
    query = "     
      PREFIX schema: <http://schema.org/>
      SELECT  ?about
      WHERE   { ?article a schema:Article .
                ?article schema:url <#{uri}> .
                ?article schema:about ?about .
              }"
    query_data = @fuseki.query(query)
    response_json = JSON.parse(query_data)
    resource = response_json["results"]["bindings"]
    about_array = []
    resource.each do |res|
      about_array.push(get_value_from_hash(res, "about"))
    end
    about_array
  end

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
