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

ActiveRecord::Schema.define(version: 20160313130057) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.integer  "state_id"
    t.boolean  "capital"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cities", ["state_id"], name: "index_cities_on_state_id", using: :btree

  create_table "demands", force: :cascade do |t|
    t.string   "title"
    t.string   "observation"
    t.string   "period"
    t.date     "start_at"
    t.string   "status"
    t.integer  "accepted_by"
    t.integer  "created_by"
    t.integer  "school_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "other_place"
  end

  add_index "demands", ["school_id"], name: "index_demands_on_school_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "demand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "groups", ["demand_id"], name: "index_groups_on_demand_id", using: :btree
  add_index "groups", ["user_id"], name: "index_groups_on_user_id", using: :btree

  create_table "information", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "city_id"
    t.integer  "state_id"
    t.integer  "school_id"
    t.integer  "expected_finish"
    t.string   "work_at"
    t.string   "occupation"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "school_name"
  end

  add_index "information", ["city_id"], name: "index_information_on_city_id", using: :btree
  add_index "information", ["school_id"], name: "index_information_on_school_id", using: :btree
  add_index "information", ["state_id"], name: "index_information_on_state_id", using: :btree
  add_index "information", ["user_id"], name: "index_information_on_user_id", using: :btree

  create_table "proposals", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "demand_id"
    t.string   "status"
    t.boolean  "sunday"
    t.boolean  "monday"
    t.boolean  "tuesday"
    t.boolean  "wednesday"
    t.boolean  "thursday"
    t.boolean  "friday"
    t.boolean  "saturday"
    t.integer  "how_many"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "proposals", ["demand_id"], name: "index_proposals_on_demand_id", using: :btree
  add_index "proposals", ["user_id"], name: "index_proposals_on_user_id", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "lati"
    t.string   "longi"
    t.integer  "state_id"
    t.integer  "city_id"
    t.string   "neighborhood"
    t.string   "cep"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "avatar"
  end

  add_index "schools", ["city_id"], name: "index_schools_on_city_id", using: :btree
  add_index "schools", ["state_id"], name: "index_schools_on_state_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "acronym"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.date     "birthday"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.string   "avatar"
    t.string   "role"
    t.string   "gender"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "cities", "states"
  add_foreign_key "demands", "schools"
  add_foreign_key "groups", "demands"
  add_foreign_key "groups", "users"
  add_foreign_key "information", "cities"
  add_foreign_key "information", "schools"
  add_foreign_key "information", "states"
  add_foreign_key "information", "users"
  add_foreign_key "proposals", "demands"
  add_foreign_key "proposals", "users"
  add_foreign_key "schools", "cities"
  add_foreign_key "schools", "states"
end
