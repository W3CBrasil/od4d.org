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
    response_json = @fuseki.query(PARTNER_SELECT_QUERY)
    resources = @fuseki_json_parser.convert(response_json)

    resources.map{|res| create_from_hash(res)}
  end

private
  def create_from_hash(partner_hash)
    partner = Partner.new
    partner.url = partner_hash["url"]
    partner.name = partner_hash["name"]
    partner.description = partner_hash["description"]
    partner.logo = partner_hash["logo"]
    partner
  end
end
