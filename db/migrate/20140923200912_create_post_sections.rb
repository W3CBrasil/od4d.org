class CreatePostSections < ActiveRecord::Migration
  def self.up
    create_table :post_sections do |t|
      t.string :name
      
      t.timestamps
    end
  end

  def self.down
    drop_table :post_sections
  end
end