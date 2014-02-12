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

ActiveRecord::Schema.define(version: 20140207203423) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "classifieds", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.integer  "user_id"
    t.integer  "state",              default: 0
    t.string   "url"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "classifieds", ["user_id", "created_at"], name: "index_classifieds_on_user_id_and_created_at", using: :btree
  add_index "classifieds", ["user_id", "state", "created_at"], name: "index_classifieds_on_user_id_and_state_and_created_at", using: :btree
  add_index "classifieds", ["user_id"], name: "index_classifieds_on_user_id", using: :btree

  create_table "quotes", force: true do |t|
    t.string   "phrase"
    t.text     "content"
    t.date     "display_date"
    t.string   "source_detail"
    t.string   "source_location"
    t.string   "source_venue"
    t.date     "source_date"
    t.string   "publication_name"
    t.string   "publication_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "quotes", ["display_date"], name: "index_quotes_on_display_date", using: :btree

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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fname"
    t.string   "lname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["fname", "lname"], name: "index_users_on_fname_and_lname", using: :btree
  add_index "users", ["lname"], name: "index_users_on_lname", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
