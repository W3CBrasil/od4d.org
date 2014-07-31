require 'uri'
require 'fuseki'
require 'fuseki_json_parser'

class PartnerDAO

  PARTNER_SELECT_QUERY = '
    PREFIX schema: <http://schema.org/>
    SELECT  ?partner ?description ?logo ?url ?name
    WHERE   { ?partner a schema:Organization .
            OPTIONAL { ?partner schema:description ?description } .
            OPTIONAL { ?partner schema:logo ?logo } .
            OPTIONAL { ?partner schema:url ?url } .
            OPTIONAL { ?partner schema:name  ?name } .
            }'

  def initialize(fuseki, fuseki_json_parser)
    @fuseki = fuseki
    @fuseki_json_parser = fuseki_json_parser
  end

  def list_partners
    load_partners
  end

  def get_partner(partner_uri)
    uri_obj = URI(partner_uri)
    partners = list_partners

    partners_found = partners.select do |p|
      p.uri.host == uri_obj.host
    end
    partners_found[0]
  end

  private
  def load_partners
    query_data = @fuseki.query(PARTNER_SELECT_QUERY)
    response_json = JSON.parse(query_data)
    resources = response_json["results"]["bindings"]
    partners = []
    resources.each do |partner_raw|
      partners.push create_from_hash(partner_raw)
    end
    partners
  end

  def get_value_from_hash(hash, key)
    hash[key]["value"]
  end

  def create_from_hash(partner_hash)
    partner_uri = URI(get_value_from_hash partner_hash, "partner")
    partner = Partner.new(partner_uri)
    partner.url = get_value_from_hash partner_hash, "url"
    partner.name = get_value_from_hash partner_hash, "name"
    partner.description = get_value_from_hash partner_hash, "description"
    partner.logo = get_value_from_hash partner_hash, "logo"
    partner
  end

end
