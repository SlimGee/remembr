class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :excerpt
      t.text :description
      t.text :keywords
      t.string :status
      t.timestamp :published_at

      t.timestamps
    end
  end
end
