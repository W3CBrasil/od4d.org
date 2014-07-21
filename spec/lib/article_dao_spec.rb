require 'article'
require 'article_dao'

describe ArticleDAO do
  context "#create_from_hash" do
    it "should convert date published to MM/DD/YYYY format" do
      articleDao = ArticleDAO.new(nil, FusekiJSONParser.new)

      article_hash = {
        "url" => "don't care",
        "headline" => "don't care",
        "author" => "don't care",
        "description" => "don't care",
        "articleSection" => "don't care",
        "datePublished" => "2014-07-25T04:13:05+03:00"
      }

      article = articleDao.create_from_hash(article_hash)

      expect(article.datePublished).to eq(DateTime.new(2014,7,25,4,13,5,"+03:00"))
    end

    it "should convert many articleSection to array of articleSection" do
      fuseki = Object.new

      def fuseki.query(string)
        '{
      "head": {
        "vars": [ "s" , "p" , "o" ]
      } ,
      "results": {
        "bindings": [
          {
            "s": { "type": "uri" , "value": "http://webfoundation.org/2014/05/affordability-takes-centre-stage-at-the-stockholm-internet-forum/" } ,
            "p": { "type": "uri" , "value": "http://schema.org/articleSection" } ,
            "o": { "type": "literal" , "value": "A" }
          } ,
          {
            "s": { "type": "uri" , "value": "http://webfoundation.org/2014/05/affordability-takes-centre-stage-at-the-stockholm-internet-forum/" } ,
            "p": { "type": "uri" , "value": "http://schema.org/articleSection" } ,
            "o": { "type": "literal" , "value": "B" }
          } ,
          {
            "s": { "type": "uri" , "value": "http://webfoundation.org/2014/05/affordability-takes-centre-stage-at-the-stockholm-internet-forum/" } ,
            "p": { "type": "uri" , "value": "http://schema.org/articleSection" } ,
            "o": { "type": "literal" , "value": "C" }
          }
        ]
      }
    }'
      end
      articleDao = ArticleDAO.new(fuseki, FusekiJSONParser.new)
      article = articleDao.list_articles[0]

      expect(article.articleSection).to eq(['A', 'B', 'C'])
    end

  end

  context "Given many articles, and an Organization" do

    fuseki = Object.new
      def fuseki.query(string)
        if (string.index("schema:Article")) then
          query_articles(string)
        else
          query_partners(string)
        end
      end

      def fuseki.query_partners(string)
        '{
      "head": {
        "vars": [ "s" , "p" , "o" ]
      } ,
      "results": {
        "bindings": [
          {
            "s": { "type": "uri" , "value": "http://www.webfoundation.org/projects/open-data-lab/" } ,
            "p": { "type": "uri" , "value": "http://www.w3.org/1999/02/22-rdf-syntax-ns#type" } ,
            "o": { "type": "uri" , "value": "http://schema.org/Organization" }
          } , 
          {
          "s": { "type": "uri" , "value": "http://www.webfoundation.org/projects/open-data-lab/" } ,
          "p": { "type": "uri" , "value": "http://schema.org/description" } ,
          "o": { "type": "literal" , "value": "Building sustainable capacity to use open data through local and regional training, action, innovation, incubation and research." }
          } , 
          { 
            "s": { "type": "uri" , "value": "http://www.webfoundation.org/projects/open-data-lab/" } ,
            "p": { "type": "uri" , "value": "http://schema.org/url" } , 
            "o": { "type": "uri" , "value": "http://www.webfoundation.org/projects/open-data-lab/" }
          } , 
          {
            "s": { "type": "uri" , "value": "http://www.webfoundation.org/projects/open-data-lab/" } ,
            "p": { "type": "uri" , "value": "http://schema.org/name" } ,
            "o": { "type": "literal" , "value": "World Wide Web Foundation" }
          } ,
          {
            "s": { "type": "uri" , "value": "http://www.webfoundation.org/projects/open-data-lab/" } ,
            "p": { "type": "uri" , "value": "http://schema.org/logo" } ,
            "o": { "type": "literal" , "value": "foundation.png" }
          }
        ]
      }
    }'
      end
    def fuseki.query_articles(string)
      '{
      "head": {
        "vars": [ "s" , "p" , "o" ]
      } ,
      "results": {
        "bindings": [
          {
            "s": { "type": "uri" , "value": "http://webfoundation.org/2014/05/affordability-takes-centre-stage-at-the-stockholm-internet-forum/" } ,
            "p": { "type": "uri" , "value": "http://www.w3.org/1999/02/22-rdf-syntax-ns#type" } ,
            "o": { "type": "uri" , "value": "http://schema.org/Article" }
          } ,
          {
            "s": { "type": "uri" , "value": "http://webfoundation.org/2014/05/affordability-takes-centre-stage-at-the-stockholm-internet-forum/" } ,
            "p": { "type": "uri" , "value": "http://schema.org/headline" } ,
            "o": { "type": "literal" , "value": "Affordability takes Centre Stage at the Stockholm Internet Forum" }
          } ,
          {
            "s": { "type": "uri" , "value": "http://webfoundation.org/2014/05/affordability-takes-centre-stage-at-the-stockholm-internet-forum/" } ,
            "p": { "type": "uri" , "value": "http://schema.org/url" } ,
            "o": { "type": "uri" , "value": "http://webfoundation.org/2014/05/affordability-takes-centre-stage-at-the-stockholm-internet-forum/" }
          } ,
          {
            "s": { "type": "uri" , "value": "http://webfoundation.org/2014/05/affordability-takes-centre-stage-at-the-stockholm-internet-forum/" } ,
            "p": { "type": "uri" , "value": "http://schema.org/publisher" } ,
            "o": { "type": "uri" , "value": "http://www.webfoundation.org" }
          },
          {
            "s": { "type": "uri" , "value": "http://webfoundation.org/2014/05/web-foundation-southbank-centre-unveil-web-we-want-festival/" } ,
            "p": { "type": "uri" , "value": "http://www.w3.org/1999/02/22-rdf-syntax-ns#type" } ,
            "o": { "type": "uri" , "value": "http://schema.org/Article" }
          } ,
          {
            "s": { "type": "uri" , "value": "http://webfoundation.org/2014/05/web-foundation-southbank-centre-unveil-web-we-want-festival/" } ,
            "p": { "type": "uri" , "value": "http://schema.org/headline" } ,
            "o": { "type": "literal" , "value": "Web Foundation, Southbank Centre unveil Web We Want Festival" }
          } ,
          {
            "s": { "type": "uri" , "value": "http://webfoundation.org/2014/05/web-foundation-southbank-centre-unveil-web-we-want-festival/" } ,
            "p": { "type": "uri" , "value": "http://schema.org/url" } ,
            "o": { "type": "uri" , "value": "http://webfoundation.org/2014/05/web-foundation-southbank-centre-unveil-web-we-want-festival/" }
          } ,
          {
            "s": { "type": "uri" , "value": "http://webfoundation.org/2014/05/web-foundation-southbank-centre-unveil-web-we-want-festival/" } ,
            "p": { "type": "uri" , "value": "http://schema.org/publisher" } ,
            "o": { "type": "uri" , "value": "http://www.webfoundation.org" }
          },
          {
            "s": { "type": "uri" , "value": "http://webfoundation.org/2014/05/webs-25th-birthday-celebrated-at-webby-awards/" } ,
            "p": { "type": "uri" , "value": "http://www.w3.org/1999/02/22-rdf-syntax-ns#type" } ,
            "o": { "type": "uri" , "value": "http://schema.org/Article" }
          } ,
          {
            "s": { "type": "uri" , "value": "http://webfoundation.org/2014/05/webs-25th-birthday-celebrated-at-webby-awards/" } ,
            "p": { "type": "uri" , "value": "http://schema.org/headline" } ,
            "o": { "type": "literal" , "value": "Web\u2019s 25th Birthday Celebrated at Webby Awards" }
          } ,
          {
            "s": { "type": "uri" , "value": "http://webfoundation.org/2014/05/webs-25th-birthday-celebrated-at-webby-awards/" } ,
            "p": { "type": "uri" , "value": "http://schema.org/url" } ,
            "o": { "type": "uri" , "value": "http://webfoundation.org/2014/05/webs-25th-birthday-celebrated-at-webby-awards/" }
          },
          {
            "s": { "type": "uri" , "value": "http://webfoundation.org/2014/05/webs-25th-birthday-celebrated-at-webby-awards/" } ,
            "p": { "type": "uri" , "value": "http://schema.org/publisher" } ,
            "o": { "type": "uri" , "value": "http://www.webfoundation.org" }
          }
        ]
      }
    }'
    end

    it "should return 2 articles" do
      articleDao = ArticleDAO.new(fuseki, FusekiJSONParser.new)
      articles = articleDao.list_articles_limitted_by(2)
      expect(articles.length).to eq(2)
    end

    it "should return an article with publisher" do
      articleDao = ArticleDAO.new(fuseki, FusekiJSONParser.new)
      article = articleDao.list_articles_limitted_by(1)[0]
      publisher = article.publisher
      expect(publisher.logo).to eq("foundation.png")
    end
  end
end
