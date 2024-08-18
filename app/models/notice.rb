class Notice < ApplicationRecord
  belongs_to :user
  validates :category, presence: true
  validates :location, presence: true
  validates :platform, presence: true
  validates :first_name, presence: true, length: {maximum: 50}
  validates :last_name, presence: true, length: {maximum: 50}
  validates :dob, presence: true
  validates :dod, presence: true, comparison: {greater_than: :dob}
  validates :wording, presence: true
  validates :relationship, presence: true

  has_person_name

  has_many_attached :images

  def self.ransackable_attributes(auth_object = nil)
    %w[category location platform first_name nickname last_name dob dod wording relationship, created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
