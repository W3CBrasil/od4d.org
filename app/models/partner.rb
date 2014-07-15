class Partner
  attr_accessor :description, :logo, :url, :name

  def slug
    name.parameterize
  end
end
