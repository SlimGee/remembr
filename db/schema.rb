# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_08_20_145027) do
  create_table "action_text_rich_texts", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "body", size: :long
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "friendly_id_slugs", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, length: { slug: 70, scope: 70 }
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", length: { slug: 140 }
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "notices", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "category"
    t.string "location"
    t.string "platform"
    t.string "first_name"
    t.string "last_name"
    t.date "dob"
    t.date "dod"
    t.string "nickname"
    t.text "wording"
    t.string "relationship"
    t.timestamp "published_at"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "successful_payment_intent_id"
    t.boolean "payment_successful", default: false
    t.string "slug"
    t.index ["slug"], name: "index_notices_on_slug", unique: true
    t.index ["user_id"], name: "index_notices_on_user_id"
  end

  create_table "payment_intents", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.string "payable_type", null: false
    t.bigint "payable_id", null: false
    t.float "amount"
    t.string "status", default: "pending", null: false
    t.bigint "transaction_id", null: false
    t.index ["payable_type", "payable_id"], name: "index_payment_intents_on_payable"
    t.index ["transaction_id"], name: "index_payment_intents_on_transaction_id"
    t.index ["user_id"], name: "index_payment_intents_on_user_id"
  end

  create_table "transactions", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reference_number", default: "", null: false
    t.timestamp "date_of_transaction"
    t.integer "application_id"
    t.string "application_name", default: "", null: false
    t.float "amount"
    t.string "currency_code", default: "", null: false
    t.float "default_currency_amount"
    t.string "default_currency_code", default: "", null: false
    t.float "transaction_service_fee"
    t.float "customer_payable_amount"
    t.float "total_transaction_amount"
    t.float "merchant_amount"
    t.string "formatted_merchant_amount", default: "", null: false
    t.string "reason_for_payment", default: "", null: false
    t.string "transaction_status", default: "", null: false
    t.string "transaction_status_code"
    t.string "transaction_status_description", default: "", null: false
    t.string "result_url", default: ""
    t.string "return_url", default: ""
    t.string "poll_url", default: ""
    t.text "transaction_metadata", size: :long, default: "{}", collation: "utf8mb4_bin"
    t.check_constraint "json_valid(`transaction_metadata`)", name: "transaction_metadata"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name", default: "", null: false
    t.string "phone", default: "", null: false
    t.string "address", default: "", null: false
    t.string "city", default: "", null: false
    t.string "country", default: "", null: false
    t.string "account_type", default: "individual", null: false
    t.boolean "marketing", default: false, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid"
    t.string "provider"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "notices", "users"
  add_foreign_key "payment_intents", "transactions"
  add_foreign_key "payment_intents", "users"
end
