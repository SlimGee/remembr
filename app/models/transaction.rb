class Transaction < ApplicationRecord
  has_one :payment_intent, class_name: "Payment::Intent"
end
