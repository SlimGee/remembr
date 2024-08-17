class CreateNotices < ActiveRecord::Migration[7.2]
  def change
    create_table :notices do |t|
      t.string :category
      t.string :location
      t.string :platform
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.date :dod
      t.string :nickname, null: true
      t.text :wording
      t.string :relationship
      t.timestamp :published_at, null: true
      t.belongs_to :user, index: true, foreign_key: true

      t.timestamps
    end
  end
end
