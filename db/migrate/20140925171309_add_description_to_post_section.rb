class AddDescriptionToPostSection < ActiveRecord::Migration
  def change
  	add_column :post_sections, :description, :string
  end
end
