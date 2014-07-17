require 'net/http'
require 'cgi'
require 'uri'

class Fuseki
    SERVER = "http://localhost:3030"
    FUSEKI_DATASET = "articles"
    REQUESTS = {:query => "query", :update => "update", :insert => "put" }

    def initialize
        @url = SERVER
        @dataset = FUSEKI_DATASET
    end

    def query(queryParam)
      queryParam = CGI::escape(queryParam)
      queryRequest = REQUESTS[:query]
      query_url = URI(@url + "/#{@dataset}/#{queryRequest}?#{queryRequest}=#{queryParam}")
      puts query_url
      Net::HTTP.get(query_url)
    end

end
