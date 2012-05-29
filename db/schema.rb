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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120529013126) do

  create_table "addresses", :force => true do |t|
    t.integer  "appeal_id"
    t.string   "postcode"
    t.string   "region"
    t.string   "district"
    t.string   "street"
    t.string   "township"
    t.string   "house"
    t.string   "building"
    t.string   "flat"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "appeals", :force => true do |t|
    t.integer  "deleted_by_id"
    t.integer  "section_id"
    t.integer  "topic_id"
    t.boolean  "public"
    t.datetime "deleted_at"
    t.string   "answer_kind"
    t.string   "code"
    t.string   "email"
    t.string   "name"
    t.string   "surname"
    t.string   "patronymic"
    t.string   "phone"
    t.string   "root_path"
    t.string   "social_status"
    t.string   "state"
    t.text     "user_agent"
    t.string   "user_ip"
    t.string   "user_proxy_ip"
    t.text     "user_referrer"
    t.text     "text"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "contexts", :force => true do |t|
    t.string   "title"
    t.string   "ancestry"
    t.string   "weight"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "contexts", ["ancestry"], :name => "index_contexts_on_ancestry"
  add_index "contexts", ["weight"], :name => "index_contexts_on_weight"

  create_table "notes", :force => true do |t|
    t.integer  "appeal_id"
    t.boolean  "public"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "notes", ["appeal_id"], :name => "index_notes_on_appeal_id"

  create_table "permissions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "context_id"
    t.string   "context_type"
    t.string   "role"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "permissions", ["user_id", "role", "context_id", "context_type"], :name => "by_user_and_role_and_context"

  create_table "redirects", :force => true do |t|
    t.integer  "appeal_id"
    t.text     "recipient"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "redirects", ["appeal_id"], :name => "index_redirects_on_appeal_id"

  create_table "registrations", :force => true do |t|
    t.integer  "appeal_id"
    t.date     "registered_on"
    t.string   "number"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "registrations", ["appeal_id"], :name => "index_registrations_on_appeal_id"

  create_table "replies", :force => true do |t|
    t.integer  "appeal_id"
    t.boolean  "public"
    t.date     "replied_on"
    t.string   "root_path"
    t.string   "number"
    t.string   "replied_by"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reviews", :force => true do |t|
    t.integer  "appeal_id"
    t.text     "recipient"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "reviews", ["appeal_id"], :name => "index_reviews_on_appeal_id"

  create_table "sections", :force => true do |t|
    t.integer  "context_id"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "topics", :force => true do |t|
    t.integer  "section_id"
    t.text     "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "topics", ["section_id"], :name => "index_topics_on_section_id"

  create_table "users", :force => true do |t|
    t.string   "uid"
    t.text     "name"
    t.text     "email"
    t.text     "nickname"
    t.text     "first_name"
    t.text     "last_name"
    t.text     "location"
    t.text     "description"
    t.text     "image"
    t.text     "phone"
    t.text     "urls"
    t.text     "raw_info"
    t.integer  "sign_in_count"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "users", ["uid"], :name => "index_users_on_uid"

end
