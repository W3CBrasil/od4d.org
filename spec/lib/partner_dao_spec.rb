require 'partner'
require 'partner_dao'

describe PartnerDAO do
  context "given caribbean institute fuseki json" do
    fuseki = Object.new
    def fuseki.query(string)
      '
      {
        "head": {
          "vars": [ "partner" , "description" , "logo" , "url" , "name" ]
        } ,
        "results": {
          "bindings": [
            {
              "description": { "type": "literal" , "value": "Facilitating open development approaches to inclusion, participation and innovation in the Caribbean, using open data as a catalyst. Hosts of the Developing the Caribbean Open Data Conference & Codesprint." } ,
              "logo": { "type": "literal" , "value": "caribbean_institute.png" } ,
              "url": { "type": "uri" , "value": "http://caribbeanopeninstitute.org/" } ,
              "partner": { "type": "uri" , "value": "http://caribbeanopeninstitute.org/" } ,
              "name": { "type": "literal" , "value": "The Caribbean Open Institute" }
            }
          ]
        }
      }
      '
    end

    it "Should list partners" do
      partnerDAO = PartnerDAO.new(fuseki, FusekiJSONParser.new)
      partners = partnerDAO.list_partners
      partner = partners[0]

      expect(partner.name).to eq("The Caribbean Open Institute")
      expect(partner.url).to eq("http://caribbeanopeninstitute.org/")
      expect(partner.logo).to eq("caribbean_institute.png")
      expect(partner.description).to eq("Facilitating open development approaches to inclusion, participation and innovation in the Caribbean, using open data as a catalyst. Hosts of the Developing the Caribbean Open Data Conference & Codesprint.")
    end

    it "Should get one partner" do
      partnerDAO = PartnerDAO.new(fuseki, FusekiJSONParser.new)
      partner = partnerDAO.get_partner("http://caribbeanopeninstitute.org")

      expect(partner.name).to eq("The Caribbean Open Institute")
      expect(partner.url).to eq("http://caribbeanopeninstitute.org/")
      expect(partner.logo).to eq("caribbean_institute.png")
      expect(partner.description).to eq("Facilitating open development approaches to inclusion, participation and innovation in the Caribbean, using open data as a catalyst. Hosts of the Developing the Caribbean Open Data Conference & Codesprint.")
    end
  end
end
