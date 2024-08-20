class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.timestamps
      t.string :reference_number, null: false, default: ""
      t.timestamp :date_of_transaction
      t.integer :application_id
      t.string :application_name, null: false, default: ""
      t.float :amount
      t.string :currency_code, null: false, default: ""
      t.float :default_currency_amount
      t.string :default_currency_code, null: false, default: ""
      t.float :transaction_service_fee
      t.float :customer_payable_amount
      t.float :total_transaction_amount
      t.float :merchant_amount
      t.string :formatted_merchant_amount, null: false, default: ""
      t.string :reason_for_payment, null: false, default: ""
      t.string :transaction_status, null: false, default: ""
      t.string :transaction_status_code
      t.string :transaction_status_description, null: false, default: ""
      t.string :result_url, null: true, default: ""
      t.string :return_url, null: true, default: ""
      t.string :poll_url, null: true, default: ""
      t.json :transaction_metadata, null: true, default: {}
    end
  end
end
