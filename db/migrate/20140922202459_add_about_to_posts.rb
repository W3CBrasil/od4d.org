class AddAboutToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :about, :string
  end
end
