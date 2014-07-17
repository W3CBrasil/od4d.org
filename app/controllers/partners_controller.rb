class PartnersController < ApplicationController
  def index
    @partners = PartnerDAO.new(Fuseki.new, FusekiJSONParser.new).list_partners
  end
end
