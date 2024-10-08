class Notice < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_person_name
  belongs_to :user, dependent: :destroy
  has_many_attached :images
  has_many :payment_intents, as: :payable, class_name: "Payment::Intent"
  has_rich_text :content

  validates :category, presence: true
  validates :location, presence: true
  validates :platform, presence: true
  validates :first_name, presence: true, length: {maximum: 50}
  validates :last_name, presence: true, length: {maximum: 50}
  validates :dob, presence: true
  validates :dod, presence: true, comparison: {greater_than: :dob}
  validates :wording, presence: true
  validates :relationship, presence: true

  scope :published, -> { where.not(published_at: nil) }

  def full_name
    "#{first_name} #{last_name}"
  end

  ransacker :created_at, type: :date do
    Arel.sql("date(created_at)")
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[category location platform first_name nickname last_name dob dod wording relationship, created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  def published?
    published_at.present?
  end
end
