class AddSlugToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :slug, :text
    add_index :posts, :slug, unique: true
  end
end
