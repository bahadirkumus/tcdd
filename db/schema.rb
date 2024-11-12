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

ActiveRecord::Schema[7.2].define(version: 2024_10_25_101731) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.date "birthday"
    t.string "role"
    t.string "gender"
    t.integer "followers_count", default: 0
    t.integer "following_count", default: 0
    t.string "bio"
    t.string "avatar_url"
    t.string "location"
    t.string "status"
    t.datetime "last_seen_at", precision: nil
    t.datetime "confirmed_at", precision: nil
    t.string "confirmation_token"
    t.jsonb "preferences", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end
end
