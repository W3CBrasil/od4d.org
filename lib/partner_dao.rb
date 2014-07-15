class PartnerDAO

  def list_all_partners
    [ add_partner_caribbean_open_institute, add_partner_open_data_developing_countries, add_partner_iniciativa_dados_abertos, add_partner_web_foundation ]
  end

  def add_partner_caribbean_open_institute
    partner = Partner.new
    partner.name = "The Caribbean Open Institute"
    partner.url = "http://www.caribbeanopeninstitute.org/"
    partner.logo = "caribbean_institute.png"
    partner.description = "Facilitating open development approaches to inclusion, participation and innovation in the
    Caribbean, using open data as a catalyst. Hosts of the Developing the Caribbean Open Data Conference & Codesprint."
    partner
  end

  def add_partner_open_data_developing_countries
    partner = Partner.new
    partner.name = "Open Data in Developing Countries"
    partner.url = "http://www.opendataresearch.org/emergingimpacts"
    partner.logo = "oddc.png"
    partner.description = "Building a research network and conducting in-depth research to understand the supply and
    use of open data worldwide. Building common methods for open data assessment, and coordinating the Open Data Barometer."
    partner
  end

  def add_partner_iniciativa_dados_abertos
    partner = Partner.new
    partner.name = "Iniciativa Latinoamericana por los Dados Abiertos"
    partner.url = "http://www.idatosabiertos.org"
    partner.logo = "ilda.png"
    partner.description = "Research and facilitating action on open data in Latin America. Conducting sectoral scoping to
    understand the potential of open data in specific domains. Facilitating dialogue between governments,
    civil society and researchers."
    partner
  end

  def add_partner_web_foundation
    partner = Partner.new
    partner.name = "World Wide Web Foundation"
    partner.url = "http://www.webfoundation.org/projects/open-data-lab/"
    partner.logo = "foundation.png"
    partner.description = "Building sustainable capacity to use open data through local and regional training, action,
    innovation, incubation and research."
    partner
  end
end
