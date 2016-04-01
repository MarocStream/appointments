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

ActiveRecord::Schema.define(version: 20160401034927) do

  create_table "addresses", force: :cascade do |t|
    t.string   "street",     limit: 255
    t.string   "apt",        limit: 255
    t.string   "postcode",   limit: 255
    t.string   "city",       limit: 255
    t.string   "state",      limit: 255
    t.string   "country",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    limit: 4
  end

  create_table "announcements", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "content",    limit: 255
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "kind",       limit: 4
  end

  create_table "appointment_group_members", force: :cascade do |t|
    t.string   "first",          limit: 255
    t.string   "last",           limit: 255
    t.date     "dob"
    t.integer  "appointment_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "appointment_group_members", ["appointment_id"], name: "index_appointment_group_members_on_appointment_id", using: :btree

  create_table "appointment_types", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.integer  "duration",              limit: 4
    t.integer  "prep_duration",         limit: 4
    t.integer  "post_duration",         limit: 4
    t.string   "color_class",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "text_color",            limit: 255
    t.boolean  "group",                               default: false
    t.integer  "group_time_per_person", limit: 4,     default: 10
    t.boolean  "overlap",                             default: false
    t.text     "description",           limit: 65535
  end

  create_table "appointments", force: :cascade do |t|
    t.integer  "user_id",             limit: 4
    t.datetime "start"
    t.integer  "appointment_type_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "min"
    t.datetime "max"
  end

  add_index "appointments", ["appointment_type_id"], name: "index_appointments_on_appointment_type_id", using: :btree
  add_index "appointments", ["min", "max"], name: "index_appointments_on_min_and_max", using: :btree
  add_index "appointments", ["start"], name: "index_appointments_on_start", using: :btree
  add_index "appointments", ["user_id"], name: "index_appointments_on_user_id", using: :btree

  create_table "closings", force: :cascade do |t|
    t.datetime "date"
    t.boolean  "all_day"
    t.string   "desc",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "duration",   limit: 4
    t.boolean  "recurring"
  end

  create_table "phones", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "number",     limit: 255
    t.string   "country",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "extension",  limit: 255
    t.integer  "kind",       limit: 4
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255,   null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.text     "desc",       limit: 65535
    t.string   "value",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: ""
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first",                  limit: 255
    t.string   "last",                   limit: 255
    t.string   "middle",                 limit: 255
    t.integer  "role",                   limit: 4,   default: 0
    t.date     "dob"
    t.integer  "gender",                 limit: 4
    t.string   "business",               limit: 255
    t.string   "phone",                  limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",        limit: 4,   default: 0,  null: false
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.string   "unconfirmed_email",      limit: 255
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
