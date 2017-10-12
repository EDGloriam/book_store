# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171009111834) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "type"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.integer  "zip"
    t.string   "country"
    t.string   "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authors_books", id: false, force: :cascade do |t|
    t.integer "author_id"
    t.integer "book_id"
    t.index ["author_id", "book_id"], name: "index_authors_books_on_author_id_and_book_id", using: :btree
    t.index ["author_id"], name: "index_authors_books_on_author_id", using: :btree
    t.index ["book_id"], name: "index_authors_books_on_book_id", using: :btree
  end

  create_table "average_caches", force: :cascade do |t|
    t.integer  "rater_id"
    t.string   "rateable_type"
    t.integer  "rateable_id"
    t.float    "avg",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", force: :cascade do |t|
    t.string   "name"
    t.string   "photo"
    t.string   "description"
    t.decimal  "price",       precision: 6, scale: 2
    t.boolean  "active"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "section"
    t.date     "publication"
    t.string   "materials"
  end

  create_table "coupons", force: :cascade do |t|
    t.string   "code"
    t.boolean  "used"
    t.decimal  "discount",   precision: 6, scale: 3
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string   "number"
    t.string   "name"
    t.string   "mmyy"
    t.string   "cvv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deliveries", force: :cascade do |t|
    t.string   "method"
    t.string   "days"
    t.decimal  "price",      precision: 6, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "dimensions", force: :cascade do |t|
    t.float    "h"
    t.float    "w"
    t.float    "d"
    t.integer  "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_dimensions_on_book_id", using: :btree
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "order_id"
    t.decimal  "unit_price",  precision: 6, scale: 3
    t.integer  "quantity"
    t.decimal  "total_price", precision: 6, scale: 3
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["book_id"], name: "index_order_items_on_book_id", using: :btree
    t.index ["order_id"], name: "index_order_items_on_order_id", using: :btree
  end

  create_table "order_statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.string   "number"
    t.decimal  "subtotal",         precision: 6, scale: 3, default: "0.0"
    t.decimal  "total",            precision: 6, scale: 3, default: "0.0"
    t.boolean  "discount_applied"
    t.decimal  "discount_amount",  precision: 6, scale: 3, default: "0.0"
    t.integer  "order_status"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.integer  "user_id"
    t.integer  "delivery_id"
    t.integer  "credit_card_id"
    t.index ["credit_card_id"], name: "index_orders_on_credit_card_id", using: :btree
    t.index ["delivery_id"], name: "index_orders_on_delivery_id", using: :btree
  end

  create_table "overall_averages", force: :cascade do |t|
    t.string   "rateable_type"
    t.integer  "rateable_id"
    t.float    "overall_avg",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rates", force: :cascade do |t|
    t.integer  "rater_id"
    t.string   "rateable_type"
    t.integer  "rateable_id"
    t.float    "stars",         null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type", using: :btree
    t.index ["rater_id"], name: "index_rates_on_rater_id", using: :btree
  end

  create_table "rating_caches", force: :cascade do |t|
    t.string   "cacheable_type"
    t.integer  "cacheable_id"
    t.float    "avg",            null: false
    t.integer  "qty",            null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.string   "text"
    t.boolean  "verified",   default: false
    t.integer  "rate_stars", default: 0
    t.integer  "user_id"
    t.integer  "book_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["book_id"], name: "index_reviews_on_book_id", using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "provider"
    t.string   "uid"
    t.text     "image"
    t.text     "name"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "dimensions", "books"
  add_foreign_key "order_items", "books"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "credit_cards"
  add_foreign_key "orders", "deliveries"
  add_foreign_key "reviews", "books"
  add_foreign_key "reviews", "users"
end
