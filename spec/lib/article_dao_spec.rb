require 'article'
require 'article_dao'

describe ArticleDAO do

  context "#find_article" do
    fuseki = Object.new
            def fuseki.query(string)
              if (string.index("schema:Article")) then
                query_articles(string)
              else
                query_partners(string)
              end
            end

            def fuseki.query_articles(string)
                '{
                  "head": {
                    "vars": [ "article" , "url" , "author" , "headline" , "summary" , "description" , "articleBody" , "articleSection" , "datePublished" , "publisher" ]
                  } ,
                  "results": {
                    "bindings": [
                      {
                        "article": { "type": "uri" , "value": "http://resource/id" } ,
                        "url": { "type": "uri" , "value": "http://resource/id" } ,
                        "author": { "type": "literal" , "value": "Dillon Mann" } ,
                        "headline": { "type": "uri" , "value": "http://webfoundation.org" } ,
                        "description": { "type": "literal" , "value": "description" } ,
                        "articleBody": { "type": "literal" , "value": "body" } ,
                        "articleSection": { "type": "literal" , "value": "General" } ,
                        "datePublished": { "type": "literal" , "value": "2014-06-23T10:59:34+00:00" } ,
                        "publisher": { "type": "uri" , "value": "http://publisher.org" }
                      }
                    ]
                  }
                }'
              end
              def fuseki.query_partners(string)
                '
                {
                  "head": {
                    "vars": [ "uri" , "description" , "logo" , "url" , "name" ]
                  } ,
                  "results": {
                    "bindings": [
                      {
                        "description": { "type": "literal" , "value": "some" } ,
                        "logo": { "type": "literal" , "value": "logo.png" } ,
                        "url": { "type": "uri" , "value": "http://publisher.org" } ,
                        "partner": { "type": "uri" , "value": "http://publisher.org" } ,
                        "name": { "type": "literal" , "value": "The Publisher" }
                      }
                    ]
                  }
                }
                '
              end

    it "should find an article by its uri" do
      articleDao = ArticleDAO.new(fuseki, FusekiJSONParser.new)
      
      article = articleDao.find_article("http://resource/id")

      expect(article.url).to eq("http://resource/id")
    end
  
  end

  context "#create_from_hash" do
    it "should convert date published to MM/DD/YYYY format" do
      articleDao = ArticleDAO.new(nil, FusekiJSONParser.new)

      article_hash = {
        "url" => { "value" => "don't care"},
        "headline" => { "value" => "don't care"},
        "author" => { "value" => "don't care"},
        "description" => { "value" => "don't care"},
        "articleSection" => { "value" => "don't care"},
        "datePublished" => { "value" => "2014-07-25T04:13:05+03:00"}
      }

      article = articleDao.create_from_hash(article_hash)

      expect(article.datePublished).to eq(DateTime.new(2014,7,25,4,13,5,"+03:00"))
    end

    it "should convert many articleSection to array of articleSection" do
      fuseki = Object.new
            def fuseki.query(string)
              if (string.index("schema:Article")) then
                query_articles(string)
              else
                query_partners(string)
              end
            end

            def fuseki.query_partners(string)
              '
              {
                "head": {
                  "vars": [ "uri" , "description" , "logo" , "url" , "name" ]
                } ,
                "results": {
                  "bindings": [
                    {
                      "description": { "type": "literal" , "value": "Facilitating open development approaches to inclusion, participation and innovation in the Caribbean, using open data as a catalyst. Hosts of the Developing the Caribbean Open Data Conference & Codesprint." } ,
                      "logo": { "type": "literal" , "value": "caribbean_institute.png" } ,
                      "url": { "type": "uri" , "value": "http://caribbeanopeninstitute.org/" } ,
                      "partner": { "type": "uri" , "value": "http://caribbeanopeninstitute.org" } ,
                      "name": { "type": "literal" , "value": "The Caribbean Open Institute" }
                    } ,
                    {
                      "description": { "type": "literal" , "value": "Building a research network and conducting in-depth research to understand the supply and use of open data worldwide. Building common methods for open data assessment, and coordinating the Open Data Barometer." } ,
                      "logo": { "type": "literal" , "value": "oddc.png" } ,
                      "url": { "type": "uri" , "value": "http://opendataresearch.org/emergingimpacts" } ,
                      "partner": { "type": "uri" , "value": "http://opendataresearch.org" } ,
                      "name": { "type": "literal" , "value": "Open Data in Developing Countries" }
                    } ,
                    {
                      "description": { "type": "literal" , "value": "Research and facilitating action on open data in Latin America. Conducting sectoral scoping to understand the potential of open data in specific domains. Facilitating dialogue between governments, civil society and researchers." } ,
                      "logo": { "type": "literal" , "value": "ilda.png" } ,
                      "url": { "type": "uri" , "value": "http://idatosabiertos.org" } ,
                      "partner": { "type": "uri" , "value": "http://idatosabiertos.org" } ,
                      "name": { "type": "literal" , "value": "Iniciativa Latinoamericana por los Dados Abiertos" }
                    } ,
                    {
                      "description": { "type": "literal" , "value": "Building sustainable capacity to use open data through local and regional training, action, innovation, incubation and research." } ,
                      "logo": { "type": "literal" , "value": "foundation.png" } ,
                      "url": { "type": "uri" , "value": "http://webfoundation.org/projects/open-data-lab/" } ,
                      "partner": { "type": "uri" , "value": "http://webfoundation.org" } ,
                      "name": { "type": "literal" , "value": "World Wide Web Foundation" }
                    }
                  ]
                }
              }
              '
            end
            def fuseki.query_articles(string)
                '{
                    "head": {
                      "vars": [ "article" , "url" , "author" , "headline" , "summary" , "description" , "articleBody" , "articleSection" , "datePublished" , "publisher" ]
                    } ,
                    "results": {
                      "bindings": [
                        {
                          "article": { "type": "uri" , "value": "http://webfoundation.org/2014/06/a-message-of-congratulations/" } ,
                          "url": { "type": "uri" , "value": "http://webfoundation.org/2014/06/a-message-of-congratulations/" } ,
                          "author": { "type": "literal" , "value": "Dillon Mann" } ,
                          "headline": { "type": "uri" , "value": "http://webfoundation.org" } ,
                          "description": { "type": "literal" , "value": "The Web Foundation team would like to send our best wishes to Sir Tim Berners-Lee and Rosemary Leith, who celebrated their marriage on Friday 20th June. Congratulations!\nAn official picture and further details are available here.\u2026" } ,
                          "articleBody": { "type": "literal" , "value": "The Web Foundation team would like to send our best wishes to Sir Tim Berners-Lee and Rosemary Leith, who celebrated their marriage on Friday 20th June. Congratulations!\nAn official picture and further details are available here." } ,
                          "articleSection": { "type": "literal" , "value": "General" } ,
                          "datePublished": { "type": "literal" , "value": "2014-06-23T10:59:34+00:00" } ,
                          "publisher": { "type": "uri" , "value": "http://webfoundation.org" }
                        } ,
                        {
                          "article": { "type": "uri" , "value": "http://webfoundation.org/2014/06/a4ai-explores-the-power-of-the-open-web-to-transform-africa-at-activate-johannesburg-summit/" } ,
                          "url": { "type": "uri" , "value": "http://webfoundation.org/2014/06/a4ai-explores-the-power-of-the-open-web-to-transform-africa-at-activate-johannesburg-summit/" } ,
                          "author": { "type": "literal" , "value": "Lauran Potter" } ,
                          "headline": { "type": "uri" , "value": "http://webfoundation.org" } ,
                          "description": { "type": "literal" , "value": "The open Web has the potential to transform Africa \u2013 and the world \u2013 combating poverty, strengthening democracy and allowing journalists to tell stories differently and engage more closely with their audiences. This was the clear message today as the \u2026" } ,
                          "articleBody": { "type": "literal" , "value": "The open Web has the potential to transform Africa \u2013 and the world \u2013 combating poverty, strengthening democracy and allowing journalists to tell stories differently and engage more closely with their audiences. This was the clear message today as the Guardian brought their popular Activate summit to Africa for the first time, with hundreds gathering in Johannesburg to hear global and African innovators speak.But in delivering the opening keynote address, Dr Bitange Ndemo, the honorary chairperson of the Alliance for Affordable Internet, struck a note of caution. Yes, the Web is delivering social innovation. Yes, African Internet penetration rates are growing exponentially. However, penetration rates remain very low across the majority of the continent and prices remain sky high \u2013 and all of this potential progress depends on the availability of affordable, reliable access to the Internet.Dr Ndemo also hit some optimistic notes, flagging how apps like Mshamba and iCow are helping to increase productivity for small farmers, and highlighting how the cocktail of technical innovation and regulatory reforms which took place during his tenure as Permanent Secretary for Communications in Kenya more than doubled the number of Internet users in the country. He delivered a strong call for governments across the continent to speed up policy and reform processes that will unlock technical innovation and drive prices down \u2013 telling policy makers to consult widely, act decisively and take calculated risks. \u201CPolicy is now more important than technology in driving prices down\u201D, he said.You can read the full text of Dr Ndemo\u2019s speech and access the accompanying presentation here. Tell us what you think in the comments below or on social media using #affordableinternet." } ,
                          "articleSection": { "type": "literal" , "value": "General" } ,
                          "datePublished": { "type": "literal" , "value": "2014-06-26T16:13:31+00:00" } ,
                          "publisher": { "type": "uri" , "value": "http://webfoundation.org" }
                        } ,
                        {
                          "article": { "type": "uri" , "value": "http://webfoundation.org/2014/06/one-year-after-first-snowden-revelations-world-wide-web-foundation-calls-for-meaningful-reform/" } ,
                          "url": { "type": "uri" , "value": "http://webfoundation.org/2014/06/one-year-after-first-snowden-revelations-world-wide-web-foundation-calls-for-meaningful-reform/" } ,
                          "author": { "type": "literal" , "value": "Alice Samson" } ,
                          "headline": { "type": "uri" , "value": "http://webfoundation.org" } ,
                          "description": { "type": "literal" , "value": "Today marks exactly one year since the first story based on whistleblower Edward Snowden\u2019s revelations appeared. To mark the anniversary, the World Wide Web Foundation is backing calls for swift and meaningful legislative reform in the US and UK.\nSpeaking \u2026" } ,
                          "articleBody": { "type": "literal" , "value": "Today marks exactly one year since the first story based on whistleblower Edward Snowden\u2019s revelations appeared. To mark the anniversary, the World Wide Web Foundation is backing calls for swift and meaningful legislative reform in the US and UK.\nSpeaking to the media, the World Wide Web Foundation\u2019s Chief Executive Officer, Anne Jellema said:\nOn the past year\u2019s revelations:\n\u201COver the past year, we\u2019ve learnt a lot about how GCHQ and the NSA have spied on web users everywhere \u2013 with scant accountability or regard for the human right to privacy. Yet, despite mounting public anger and a UN resolution, we have not seen meaningful legislative reform in the either UK or the US.\n\u201CAttention has largely focused on the US and the UK, but in fact, the issue is far broader than this. The Web Foundation\u2019s 2013 Web Index showed that 94% of countries around the world are flouting norms and do not meet best practice standards for checks and balances on government interception of electronic communications.*\n\u201CEdward Snowden has repeatedly said that his greatest fear is that no change occurs as a result of his whistleblowing. It is up to us \u2013 ordinary Web users everywhere \u2013 to stop this fear from being realised by demanding positive action from our governments.\u201D\nOn the USA Freedom act:\n\u201CThe recent USA Freedom Act does not go nearly far enough. The Bill recognises that bulk data collection should be stopped, but the loopholes inserted will render it toothless.\u201D\nOn the need for an independent enquiry and legislative change in the UK:\n\u201CIn the UK, the \u2018Don\u2019t Spy on Us\u2019 coalition is calling for an independent enquiry, followed by legislative reform based on six key principles. We wholly support this call \u2013 now is the time to update Britain\u2019s analogue laws for our digital age. Intelligence agencies need powers to keep people safe, but these powers must be necessary and proportionate. Bulk data collection by default, with laws made and enforced in secret can never be acceptable.\u201D\nYou can get involved in our Web We Want campaign that is helping to empower ordinary people across the world to shape the future of the Web at www.webwewant.org" } ,
                          "articleSection": { "type": "literal" , "value": "General" } ,
                          "datePublished": { "type": "literal" , "value": "2014-06-05T19:19:36+00:00" } ,
                          "publisher": { "type": "uri" , "value": "http://webfoundation.org" }
                        }
                      ]
                    }
                  }'
              end
      articleDao = ArticleDAO.new(fuseki, FusekiJSONParser.new)
      article = articleDao.list_articles[0]

      expect(article.articleSection).to eq(["General"])
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
        '
        {
          "head": {
            "vars": [ "uri" , "description" , "logo" , "url" , "name" ]
          } ,
          "results": {
            "bindings": [
              {
                "description": { "type": "literal" , "value": "Facilitating open development approaches to inclusion, participation and innovation in the Caribbean, using open data as a catalyst. Hosts of the Developing the Caribbean Open Data Conference & Codesprint." } ,
                "logo": { "type": "literal" , "value": "caribbean_institute.png" } ,
                "url": { "type": "uri" , "value": "http://caribbeanopeninstitute.org/" } ,
                "partner": { "type": "uri" , "value": "http://caribbeanopeninstitute.org" } ,
                "name": { "type": "literal" , "value": "The Caribbean Open Institute" }
              } ,
              {
                "description": { "type": "literal" , "value": "Building a research network and conducting in-depth research to understand the supply and use of open data worldwide. Building common methods for open data assessment, and coordinating the Open Data Barometer." } ,
                "logo": { "type": "literal" , "value": "oddc.png" } ,
                "url": { "type": "uri" , "value": "http://opendataresearch.org/emergingimpacts" } ,
                "partner": { "type": "uri" , "value": "http://opendataresearch.org" } ,
                "name": { "type": "literal" , "value": "Open Data in Developing Countries" }
              } ,
              {
                "description": { "type": "literal" , "value": "Research and facilitating action on open data in Latin America. Conducting sectoral scoping to understand the potential of open data in specific domains. Facilitating dialogue between governments, civil society and researchers." } ,
                "logo": { "type": "literal" , "value": "ilda.png" } ,
                "url": { "type": "uri" , "value": "http://idatosabiertos.org" } ,
                "partner": { "type": "uri" , "value": "http://idatosabiertos.org" } ,
                "name": { "type": "literal" , "value": "Iniciativa Latinoamericana por los Dados Abiertos" }
              } ,
              {
                "description": { "type": "literal" , "value": "Building sustainable capacity to use open data through local and regional training, action, innovation, incubation and research." } ,
                "logo": { "type": "literal" , "value": "foundation.png" } ,
                "url": { "type": "uri" , "value": "http://webfoundation.org/projects/open-data-lab/" } ,
                "partner": { "type": "uri" , "value": "http://webfoundation.org" } ,
                "name": { "type": "literal" , "value": "World Wide Web Foundation" }
              }
            ]
          }
        }
        '
      end
    def fuseki.query_articles(string)
      '{
        "head": {
          "vars": [ "article" , "url" , "author" , "headline" , "summary" , "description" , "articleBody" , "articleSection" , "datePublished" , "publisher" ]
        } ,
        "results": {
          "bindings": [
            {
              "article": { "type": "uri" , "value": "http://webfoundation.org/2014/06/a-message-of-congratulations/" } ,
              "url": { "type": "uri" , "value": "http://webfoundation.org/2014/06/a-message-of-congratulations/" } ,
              "author": { "type": "literal" , "value": "Dillon Mann" } ,
              "headline": { "type": "uri" , "value": "http://webfoundation.org" } ,
              "description": { "type": "literal" , "value": "The Web Foundation team would like to send our best wishes to Sir Tim Berners-Lee and Rosemary Leith, who celebrated their marriage on Friday 20th June. Congratulations!\nAn official picture and further details are available here.\u2026" } ,
              "articleBody": { "type": "literal" , "value": "The Web Foundation team would like to send our best wishes to Sir Tim Berners-Lee and Rosemary Leith, who celebrated their marriage on Friday 20th June. Congratulations!\nAn official picture and further details are available here." } ,
              "articleSection": { "type": "literal" , "value": "General" } ,
              "datePublished": { "type": "literal" , "value": "2014-06-23T10:59:34+00:00" } ,
              "publisher": { "type": "uri" , "value": "http://webfoundation.org" }
            } ,
            {
              "article": { "type": "uri" , "value": "http://webfoundation.org/2014/06/a4ai-explores-the-power-of-the-open-web-to-transform-africa-at-activate-johannesburg-summit/" } ,
              "url": { "type": "uri" , "value": "http://webfoundation.org/2014/06/a4ai-explores-the-power-of-the-open-web-to-transform-africa-at-activate-johannesburg-summit/" } ,
              "author": { "type": "literal" , "value": "Lauran Potter" } ,
              "headline": { "type": "uri" , "value": "http://webfoundation.org" } ,
              "description": { "type": "literal" , "value": "The open Web has the potential to transform Africa \u2013 and the world \u2013 combating poverty, strengthening democracy and allowing journalists to tell stories differently and engage more closely with their audiences. This was the clear message today as the \u2026" } ,
              "articleBody": { "type": "literal" , "value": "The open Web has the potential to transform Africa \u2013 and the world \u2013 combating poverty, strengthening democracy and allowing journalists to tell stories differently and engage more closely with their audiences. This was the clear message today as the Guardian brought their popular Activate summit to Africa for the first time, with hundreds gathering in Johannesburg to hear global and African innovators speak.But in delivering the opening keynote address, Dr Bitange Ndemo, the honorary chairperson of the Alliance for Affordable Internet, struck a note of caution. Yes, the Web is delivering social innovation. Yes, African Internet penetration rates are growing exponentially. However, penetration rates remain very low across the majority of the continent and prices remain sky high \u2013 and all of this potential progress depends on the availability of affordable, reliable access to the Internet.Dr Ndemo also hit some optimistic notes, flagging how apps like Mshamba and iCow are helping to increase productivity for small farmers, and highlighting how the cocktail of technical innovation and regulatory reforms which took place during his tenure as Permanent Secretary for Communications in Kenya more than doubled the number of Internet users in the country. He delivered a strong call for governments across the continent to speed up policy and reform processes that will unlock technical innovation and drive prices down \u2013 telling policy makers to consult widely, act decisively and take calculated risks. \u201CPolicy is now more important than technology in driving prices down\u201D, he said.You can read the full text of Dr Ndemo\u2019s speech and access the accompanying presentation here. Tell us what you think in the comments below or on social media using #affordableinternet." } ,
              "articleSection": { "type": "literal" , "value": "General" } ,
              "datePublished": { "type": "literal" , "value": "2014-06-26T16:13:31+00:00" } ,
              "publisher": { "type": "uri" , "value": "http://webfoundation.org"}
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
