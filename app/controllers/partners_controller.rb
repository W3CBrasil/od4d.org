class PartnersController < ApplicationController
  def index
    @partners = PartnerDAO.new.list_all_partners
  end
end
