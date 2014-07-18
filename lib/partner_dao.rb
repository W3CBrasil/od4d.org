require 'fuseki'
require 'fuseki_json_parser'

class PartnerDAO

  PARTNER_SELECT_QUERY = '
    PREFIX schema: <http://schema.org/>
    SELECT  ?s ?p ?o
    WHERE   { ?s a schema:Organization .
              ?s ?p ?o}'

  def initialize(fuseki, fuseki_json_parser)
    @fuseki = fuseki
    @fuseki_json_parser = fuseki_json_parser
  end

  def list_partners
    load_partners.map{|k, v| v}
  end

  def get_partner(partner_uri)
    load_partners[partner_uri]
  end

private
  def load_partners
    response_json = @fuseki.query(PARTNER_SELECT_QUERY)
    resources = @fuseki_json_parser.convert(response_json)
    resources.each{|uri, res| resources[uri] = create_from_hash(uri, res)}
    resources
  end

  def create_from_hash(uri, partner_hash)
    partner = Partner.new(uri)
    partner.url = partner_hash["url"]
    partner.name = partner_hash["name"]
    partner.description = partner_hash["description"]
    partner.logo = partner_hash["logo"]
    partner
  end
end
