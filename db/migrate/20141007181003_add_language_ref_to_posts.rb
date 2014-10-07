class AddLanguageRefToPosts < ActiveRecord::Migration
  def change
    add_reference :posts, :languages, index: true
  end
end
