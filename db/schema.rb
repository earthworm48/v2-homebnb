# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151219100753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.string  "provider"
    t.string  "uid"
    t.string  "token"
    t.integer "user_id"
  end

  create_table "listings", force: :cascade do |t|
    t.string   "city"
    t.string   "address"
    t.integer  "price_per_night"
    t.string   "room_type"
    t.integer  "no_of_guest"
    t.string   "name"
    t.string   "description"
    t.json     "avatars"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "user_id"
  end

  add_index "listings", ["user_id"], name: "index_listings_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.string   "email",                                                           null: false
    t.string   "encrypted_password", limit: 128,                                  null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128,                                  null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "name"
    t.string   "url"
    t.string   "image_url",                      default: "/assets/user-pic.png"
    t.string   "authentications"
    t.string   "location"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

  add_foreign_key "listings", "users"
end
