class AddSectionRefToPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :post_sections, index: true
  end
end
