class CreatePaymentIntents < ActiveRecord::Migration[7.2]
  def change
    create_table :payment_intents do |t|
      t.timestamps
      t.references :user, null: false, foreign_key: true
      t.references :payable, polymorphic: true, null: false
      t.float :amount
      t.string :status, null: false, default: "pending"
      t.references :transaction, null: false, foreign_key: true
    end
  end
end
