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
end
