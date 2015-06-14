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

ActiveRecord::Schema.define(version: 20150614051815) do

  create_table "addresses", force: true do |t|
    t.string   "street"
    t.string   "apt"
    t.string   "postcode"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "announcements", force: true do |t|
    t.string   "name"
    t.string   "content"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "kind"
  end

  create_table "appointment_types", force: true do |t|
    t.string   "name"
    t.integer  "duration"
    t.integer  "prep_duration"
    t.integer  "post_duration"
    t.string   "color_class"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "text_color"
  end

  create_table "appointments", force: true do |t|
    t.integer  "user_id"
    t.datetime "start"
    t.integer  "appointment_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "min"
    t.datetime "max"
  end

  add_index "appointments", ["appointment_type_id"], name: "index_appointments_on_appointment_type_id", using: :btree
  add_index "appointments", ["min", "max"], name: "index_appointments_on_min_and_max", using: :btree
  add_index "appointments", ["start"], name: "index_appointments_on_start", using: :btree
  add_index "appointments", ["user_id"], name: "index_appointments_on_user_id", using: :btree

  create_table "closings", force: true do |t|
    t.datetime "date"
    t.boolean  "all_day"
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phones", force: true do |t|
    t.integer  "user_id"
    t.string   "number"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "extension"
    t.integer  "kind"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "settings", force: true do |t|
    t.string   "name"
    t.text     "desc"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first"
    t.string   "last"
    t.string   "middle"
    t.integer  "role",                   default: 0
    t.date     "dob"
    t.integer  "gender"
    t.string   "business"
    t.string   "phone"
    t.string   "family"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
