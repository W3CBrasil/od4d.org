require 'uri'
require 'rdf'
require 'rdf/turtle'

class Turtle
  def initialize(prefixes = {})
    @prefixes = prefixes
    @resources = []
  end

  def add_resource(resource)
    @resources.push(resource)
    self
  end

  def to_s
    graph = create_graph_from_resources
    output = RDF::Turtle::Writer.buffer(prefixes: @prefixes) do |writer|
      graph.each_statement do |statement|
        writer << statement
      end
    end
    output
  end

  private
  def create_graph_from_resources
    graph = RDF::Graph.new

    @resources.each do |resource|
      resourceUri = RDF::URI.new(resource.uri)
      graph << [resourceUri, RDF.type, RDF::SCHEMA.Article]
      resource.properties.each do |key, object |
        add_triple_to_graph(graph, resourceUri, key, object)
      end
    end
    graph
  end

  def add_triple_to_graph(graph, resourceUri, key, object)
    predicate = RDF::SCHEMA.send(key)
    add_triple_to_graph_with_predicate(graph, resourceUri, predicate, object)
  end

  def add_triple_to_graph_with_predicate(graph, resourceUri, predicate, object)
    triple_check(resourceUri, predicate, object)
    try_add_array_triple(graph, resourceUri, predicate, object) ||
      try_add_uri_triple(graph, resourceUri, predicate, object) ||
      add_normal_triple(graph, resourceUri, predicate, object)
  end

  def add_normal_triple(graph, resourceUri, predicate, object)
    graph << [resourceUri, predicate, object ]
    true
  end

  def try_add_array_triple(graph, resourceUri, predicate, object)
    result = object.is_a? Array
    object.each do |obj|
      add_triple_to_graph_with_predicate(graph, resourceUri, predicate, obj)
    end if result
    result
  end

  def try_add_uri_triple(graph, resourceUri, predicate, object)
    result = str_is_uri?(object)
    graph << [resourceUri, predicate, RDF::URI.new(object) ] if result
    result
  end


  def triple_check(resourceUri, key, object)
    raise "Empty resource" if resourceUri.nil?
    raise "Empty key, for object #{object}" if key.nil? || key.to_s.empty?
    raise "Empty object, for key #{key}" if object.nil? || object.to_s.empty?
  end

  def str_is_uri?(str)
    str =~ /\A#{URI::regexp}\z/   
  end

end
