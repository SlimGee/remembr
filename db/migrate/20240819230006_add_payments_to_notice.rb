class AddPaymentsToNotice < ActiveRecord::Migration[7.2]
  def change
    add_column :notices, :successful_payment_intent_id, :bigint, null: true
    add_column :notices, :payment_successful, :boolean, default: false
  end
end
