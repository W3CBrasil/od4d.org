class LearnController < ApplicationController
  def how_to_integrate_with_od4d
  end
  def introduction_to_rdf_and_rdfa
  end
  def how_to_create_a_semantic_page
  end
  def glossary
  end
  def concepts
  end
  def ref_material
    redirect_to controller: :articles, action: :show, params: {uri: "http://platform.od4d.org/posts/40"}
  end
  def capacity_building
  end
end
