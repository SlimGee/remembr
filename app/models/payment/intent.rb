class Payment::Intent < ApplicationRecord
  belongs_to :transfer, class_name: "Transaction", foreign_key: :transaction_id, dependent: :destroy
  belongs_to :user, dependent: :destroy
  belongs_to :payable, polymorphic: true
end
