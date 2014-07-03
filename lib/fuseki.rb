require 'net/http'
require 'cgi'
require 'uri'

class Fuseki
    REQUESTS = {:query => "query", :update => "update", :insert => "put" }
    
    def initialize(url, datasetName)
        @url = url
        @dataset = datasetName
    end

    def query(queryParam)
      queryParam = CGI::escape(queryParam)
      queryRequest = REQUESTS[:query]
      query_url = URI(@url + "/#{@dataset}/#{queryRequest}?#{queryRequest}=#{queryParam}")
      puts query_url
      Net::HTTP.get(query_url)
    end

end


