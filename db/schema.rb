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

ActiveRecord::Schema.define(version: 2018_10_05_094615) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "posts", force: :cascade do |t|
    t.string "status"
    t.string "city"
    t.float "rent_with_expenses_amount"
    t.string "user_id"
    t.string "description"
    t.string "firstname"
    t.string "lastname"
    t.float "property_surface"
    t.string "coordinates"
    t.string "address"
    t.string "pictures"
    t.integer "rooms_count"
    t.string "property_id"
    t.integer "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link"
    t.integer "nb_posts_user"
    t.string "reposting_history"
    t.string "market_price"
    t.string "studapart_price"
    t.string "labels"
    t.string "syntax_checking"
    t.string "languages_detected"
    t.integer "description_suspiciousness"
    t.string "pictures_informations"
    t.string "input_errors"
    t.boolean "email_detected"
    t.boolean "url_detected"
    t.boolean "phone_detected"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
