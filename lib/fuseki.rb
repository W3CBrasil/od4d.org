require 'net/http'
require 'cgi'
require 'uri'

class Fuseki
  SERVER = "http://localhost"
  PORT = "3030"
  FUSEKI_DATASET = "articles"
  INSERT_PATH = '/articles/data?default'
  REQUESTS = {:query => "query", :update => "update", :insert => "put" }

  def initialize
      @url = SERVER + ":" + PORT
      @dataset = FUSEKI_DATASET
  end

  def query(queryParam)
    queryParam = CGI::escape(queryParam)
    queryRequest = REQUESTS[:query]
    query_url = URI(@url + "/#{@dataset}/#{queryRequest}?#{queryRequest}=#{queryParam}")
    Net::HTTP.get(query_url)
  end

  def insert(turtle)
      begin
        headers = {}
        headers["Content-Type"] = "text/turtle;charset=utf-8;charset=utf-8"
        request = Net::HTTP::Post.new(INSERT_PATH)
        request.initialize_http_header(headers)
        request.body = turtle
        response = Net::HTTP.new("localhost", PORT).start {|http| http.request(request) }

      rescue => e
        # findout what to do
      end
  end

  def update(query, body = "")
    queryParam = CGI::escape(query)
    queryRequest = REQUESTS[:update]
      begin
        headers = {}
        headers["Content-Type"] = "application/x-www-form-urlencoded"
        request = Net::HTTP::Post.new("/#{@dataset}/#{queryRequest}?#{queryRequest}=#{queryParam}")
        request.initialize_http_header(headers)
        request.body = body
        response = Net::HTTP.new("localhost", PORT).start {|http| http.request(request) }

      rescue => e
        # findout what to do
      end
  end

end
