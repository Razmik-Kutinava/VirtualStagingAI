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

ActiveRecord::Schema[8.1].define(version: 2026_02_13_150000) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "favorites", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "generation_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["generation_id"], name: "index_favorites_on_generation_id"
    t.index ["user_id", "generation_id"], name: "index_favorites_on_user_id_and_generation_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "folders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "icon"
    t.string "name", null: false
    t.integer "project_id", null: false
    t.integer "sort_order", default: 0
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_folders_on_project_id"
  end

  create_table "generations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "error"
    t.integer "input_image_id", null: false
    t.integer "output_image_id"
    t.string "status", default: "queued"
    t.integer "style_id", null: false
    t.integer "tokens_spent", default: 1, null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["input_image_id"], name: "index_generations_on_input_image_id"
    t.index ["output_image_id"], name: "index_generations_on_output_image_id"
    t.index ["style_id"], name: "index_generations_on_style_id"
    t.index ["user_id"], name: "index_generations_on_user_id"
  end

  create_table "images", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "deleted_at"
    t.integer "folder_id"
    t.string "kind", null: false
    t.json "metadata"
    t.integer "project_id"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["folder_id"], name: "index_images_on_folder_id"
    t.index ["project_id"], name: "index_images_on_project_id"
    t.index ["user_id"], name: "index_images_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "amount_cents"
    t.string "card_last_four"
    t.string "card_type"
    t.string "cloudpayments_invoice_id"
    t.string "cloudpayments_transaction_id"
    t.datetime "created_at", null: false
    t.string "currency", default: "RUB"
    t.json "metadata"
    t.datetime "paid_at"
    t.string "status", default: "pending"
    t.integer "token_package_id", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["cloudpayments_transaction_id"], name: "index_payments_on_cloudpayments_transaction_id", unique: true
    t.index ["token_package_id"], name: "index_payments_on_token_package_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name", null: false
    t.string "property_address"
    t.string "property_type"
    t.string "status", default: "active"
    t.text "thumbnail_url"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "styles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.text "prompt"
    t.datetime "updated_at", null: false
  end

  create_table "token_packages", force: :cascade do |t|
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.integer "price_cents"
    t.integer "tokens_amount"
    t.datetime "updated_at", null: false
    t.integer "validity_days", default: 90
  end

  create_table "token_purchases", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "expires_at"
    t.datetime "purchased_at"
    t.integer "token_package_id", null: false
    t.integer "tokens_remaining"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["token_package_id"], name: "index_token_purchases_on_token_package_id"
    t.index ["user_id"], name: "index_token_purchases_on_user_id"
  end

  create_table "token_transactions", force: :cascade do |t|
    t.integer "amount"
    t.datetime "created_at", null: false
    t.integer "generation_id"
    t.string "operation"
    t.integer "token_purchase_id"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["generation_id"], name: "index_token_transactions_on_generation_id"
    t.index ["token_purchase_id"], name: "index_token_transactions_on_token_purchase_id"
    t.index ["user_id"], name: "index_token_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "confirmation_sent_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.string "unconfirmed_email"
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "favorites", "generations"
  add_foreign_key "favorites", "users"
  add_foreign_key "folders", "projects"
  add_foreign_key "generations", "images", column: "input_image_id"
  add_foreign_key "generations", "images", column: "output_image_id"
  add_foreign_key "generations", "styles"
  add_foreign_key "generations", "users"
  add_foreign_key "images", "folders"
  add_foreign_key "images", "projects"
  add_foreign_key "images", "users"
  add_foreign_key "payments", "token_packages"
  add_foreign_key "payments", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "token_purchases", "token_packages"
  add_foreign_key "token_purchases", "users"
  add_foreign_key "token_transactions", "generations"
  add_foreign_key "token_transactions", "token_purchases"
  add_foreign_key "token_transactions", "users"
end
