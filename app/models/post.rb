class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :user
  has_rich_text :content
  has_one_attached :cover

  before_save :set_published_at

  validates :title, presence: true
  validates :content, presence: true

  enum :status, {draft: "draft", published: "published"}
  scope :published, -> { where(status: "published") }

  def set_published_at
    self.published_at = Time.zone.now if status_changed? && published?
  end
end
