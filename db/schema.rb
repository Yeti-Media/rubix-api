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

ActiveRecord::Schema.define(version: 20140519230436) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0
    t.integer  "attempts",   default: 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "descriptors", force: true do |t|
    t.xml      "body"
    t.integer  "pattern_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "descriptors", ["pattern_id"], name: "index_descriptors_on_pattern_id", using: :btree

  create_table "histrograms", force: true do |t|
    t.integer  "pattern_id"
    t.text     "gray"
    t.text     "color"
    t.text     "hsv"
    t.text     "landscape"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "histrograms", ["pattern_id"], name: "index_histrograms_on_pattern_id", using: :btree

  create_table "patterns", force: true do |t|
    t.string   "file"
    t.string   "label"
    t.string   "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "aid"
    t.integer  "category_id"
    t.integer  "trainer_id"
    t.integer  "position"
  end

  add_index "patterns", ["aid"], name: "index_patterns_on_aid", using: :btree

  create_table "scenarios", force: true do |t|
    t.integer  "file"
    t.text     "result"
    t.xml      "descriptors"
    t.string   "url"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trainers", force: true do |t|
    t.integer  "xml_file"
    t.integer  "if_file"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "patterns_count", default: 0
  end

  add_index "trainers", ["user_id"], name: "index_trainers_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "access_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "account_type"
    t.string   "third_party_id"
  end

  add_index "users", ["access_token", "account_type"], name: "index_users_on_access_token_and_account_type", using: :btree
  add_index "users", ["account_type"], name: "index_users_on_account_type", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["third_party_id"], name: "index_users_on_third_party_id", using: :btree

end
