require 'fuseki_json_parser'

describe FusekiJSONParser do
  context "Converting a simple fuseki triple to ruby hash" do
    fuseki_json = '{
      "head": {
        "vars": [ "s" , "p" , "o" ]
      },
      "results": {
        "bindings": [
          {
            "s": { "type": "uri" , "value": "http://www.example.org" } ,
            "p": { "type": "uri" , "value": "http://www.w3.org/1999/02/22-rdf-syntax-ns#type" } ,
            "o": { "type": "uri" , "value": "http://schema.org/Article" }
          }
        ]
      }
    }'

    it "should convert to hash object, with property value instead of triples" do
      fuseki_parser = FusekiJSONParser.new
      resource_hashes = fuseki_parser.convert(fuseki_json)

      expect(resource_hashes.length).to eq(1)
      expect(resource_hashes["http://www.example.org"]["type"]).to eq("http://schema.org/Article")
    end
  end

  context "Converting a fuseki with two triples of two different resources to ruby hash" do
    fuseki_json = '{
      "head": {
        "vars": [ "subject" , "predicate" , "object" ]
      },
      "results": {
        "bindings": [
          {
            "subject": { "type": "uri" , "value": "http://www.example.org" } ,
            "predicate": { "type": "uri" , "value": "http://www.w3.org/1999/02/22-rdf-syntax-ns#type" } ,
            "object": { "type": "uri" , "value": "http://schema.org/Article" }
          },
          {
            "subject": { "type": "uri" , "value": "http://www.example.org" } ,
            "predicate": { "type": "uri" , "value": "http://schema.org/description" } ,
            "object": { "type": "text" , "value": "Somewhat a short description" }
          },
          {
            "subject": { "type": "uri" , "value": "http://www.whatever.org" } ,
            "predicate": { "type": "uri" , "value": "http://schema.org/type" } ,
            "object": { "type": "uri" , "value": "http://schema.org/Organization" }
          }
        ]
      }
    }'

    it "should convert to hash object, with property value instead of triples" do
      fuseki_parser = FusekiJSONParser.new
      resource_hashes = fuseki_parser.convert(fuseki_json)

      expect(resource_hashes.length).to eq(2)
      expect(resource_hashes["http://www.example.org"]["type"]).to eq("http://schema.org/Article")
      expect(resource_hashes["http://www.example.org"]["description"]).to eq("Somewhat a short description")

      expect(resource_hashes["http://www.whatever.org"]["type"]).to eq("http://schema.org/Organization")
    end
  end

  context "Converting a fuseki with two triples of two different resources to ruby hash" do
    fuseki_json = '{
      "head": {
        "vars": [ "subject" , "predicate" , "object" ]
      },
      "results": {
        "bindings": [
          {
            "subject": { "type": "uri" , "value": "http://www.example.org" } ,
            "predicate": { "type": "uri" , "value": "http://schema.org/category" } ,
            "object": { "type": "uri" , "value": "Project" }
          },
          {
            "subject": { "type": "uri" , "value": "http://www.example.org" } ,
            "predicate": { "type": "uri" , "value": "http://schema.org/category" } ,
            "object": { "type": "text" , "value": "General" }
          }
        ]
      }
    }'

    it "should convert to hash object, with property value instead of triples" do
      fuseki_parser = FusekiJSONParser.new
      resource_hashes = fuseki_parser.convert(fuseki_json)

      expect(resource_hashes.length).to eq(1)
      expect(resource_hashes["http://www.example.org"]["category"].length).to eq(2)
      expect(resource_hashes["http://www.example.org"]["category"][0]).to eq("Project")
      expect(resource_hashes["http://www.example.org"]["category"][1]).to eq("General")
    end
  end

end
