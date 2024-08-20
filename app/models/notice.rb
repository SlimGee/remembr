class Notice < ApplicationRecord
  has_person_name
  belongs_to :user, dependent: :destroy
  has_many_attached :images
  has_many :payment_intents, as: :payable, class_name: "Payment::Intent"

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

  ransacker :created_at, type: :date do
    Arel.sql("date(created_at)")
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[category location platform first_name nickname last_name dob dod wording relationship, created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
