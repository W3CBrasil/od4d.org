require 'partner'
require 'partner_dao'

describe PartnerDAO do
  context "given caribbean institute fuseki json" do
    fuseki = Object.new
    def fuseki.query(string)
      '{
          "head": {
            "vars": [ "s" , "p" , "o" ]
          } ,
          "results": {
            "bindings": [
              {
                "s": { "type": "uri" , "value": "http://www.caribbeanopeninstitute.org/" } ,
                "p": { "type": "uri" , "value": "http://www.w3.org/1999/02/22-rdf-syntax-ns#type" } ,
                "o": { "type": "uri" , "value": "http://schema.org/Organization" }
              } ,
              {
                "s": { "type": "uri" , "value": "http://www.caribbeanopeninstitute.org/" } ,
                "p": { "type": "uri" , "value": "http://schema.org/description" } ,
                "o": { "type": "literal" , "value": "Facilitating open development approaches to inclusion, participation and innovation in the Caribbean, using open data as a catalyst. Hosts of the Developing the Caribbean Open Data Conference & Codesprint." }
              } ,
              {
                "s": { "type": "uri" , "value": "http://www.caribbeanopeninstitute.org/" } ,
                "p": { "type": "uri" , "value": "http://schema.org/url" } ,
                "o": { "type": "uri" , "value": "http://www.caribbeanopeninstitute.org/" }
              } ,
              {
                "s": { "type": "uri" , "value": "http://www.caribbeanopeninstitute.org/" } ,
                "p": { "type": "uri" , "value": "http://schema.org/name" } ,
                "o": { "type": "literal" , "value": "The Caribbean Open Institute" }
              } ,
              {
                "s": { "type": "uri" , "value": "http://www.caribbeanopeninstitute.org/" } ,
                "p": { "type": "uri" , "value": "http://schema.org/logo" } ,
                "o": { "type": "literal" , "value": "caribbean_institute.png" }
              }
            ]
          }
        }'
    end

    it "Should list partners" do
      partnerDAO = PartnerDAO.new(fuseki, FusekiJSONParser.new)
      partners = partnerDAO.list_partners
      partner = partners[0]

      expect(partner.name).to eq("The Caribbean Open Institute")
      expect(partner.url).to eq("http://www.caribbeanopeninstitute.org/")
      expect(partner.logo).to eq("caribbean_institute.png")
      expect(partner.description).to eq("Facilitating open development approaches to inclusion, participation and innovation in the Caribbean, using open data as a catalyst. Hosts of the Developing the Caribbean Open Data Conference & Codesprint.")
    end

    it "Should get one partner" do
      partnerDAO = PartnerDAO.new(fuseki, FusekiJSONParser.new)
      partner = partnerDAO.get_partner("http://www.caribbeanopeninstitute.org")

      expect(partner.name).to eq("The Caribbean Open Institute")
      expect(partner.url).to eq("http://www.caribbeanopeninstitute.org/")
      expect(partner.logo).to eq("caribbean_institute.png")
      expect(partner.description).to eq("Facilitating open development approaches to inclusion, participation and innovation in the Caribbean, using open data as a catalyst. Hosts of the Developing the Caribbean Open Data Conference & Codesprint.")
    end
  end
end
