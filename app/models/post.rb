class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :user
  has_rich_text :content
  has_one_attached :cover

  enum status: {draft: "draft", published: "published"}
end
