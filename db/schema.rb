# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_13_173124) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.text "description"
    t.float "negative_balance"
    t.float "positive_balance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "category_monthly_stats", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "account_id"
    t.integer "month"
    t.integer "year"
    t.text "category"
    t.float "negative_balance", default: 0.0
    t.float "positive_balance", default: 0.0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id", "category", "month", "year"], name: "index_cms_on_acount_month_year_cat", unique: true
    t.index ["account_id"], name: "index_category_monthly_stats_on_account_id"
    t.index ["category"], name: "index_category_monthly_stats_on_category", unique: true
    t.index ["month"], name: "index_category_monthly_stats_on_month"
    t.index ["year"], name: "index_category_monthly_stats_on_year"
  end

  create_table "monthly_stats", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "account_id"
    t.integer "month"
    t.integer "year"
    t.float "negative_balance", default: 0.0
    t.float "positive_balance", default: 0.0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id", "month", "year"], name: "index_monthly_stats_on_account_id_and_month_and_year", unique: true
    t.index ["account_id"], name: "index_monthly_stats_on_account_id"
  end

  create_table "transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.date "date"
    t.text "description"
    t.float "amount"
    t.text "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category"], name: "index_transactions_on_category"
    t.index ["date"], name: "index_transactions_on_date"
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["id"], name: "index_users_on_id"
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "category_monthly_stats", "accounts"
  add_foreign_key "monthly_stats", "accounts"
  add_foreign_key "transactions", "users"
end
