class Partner
  attr_accessor :uri, :description, :logo, :url, :name

  def initialize(uri)
    @uri = uri
  end

  def slug
    name.parameterize
  end
end
