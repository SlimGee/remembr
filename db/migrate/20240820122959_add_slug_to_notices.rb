class AddSlugToNotices < ActiveRecord::Migration[7.2]
  def change
    add_column :notices, :slug, :string
    add_index :notices, :slug, unique: true
  end
end
