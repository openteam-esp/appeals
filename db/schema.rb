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

ActiveRecord::Schema.define(:version => 20111201015134) do

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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appeals", :force => true do |t|
    t.string   "surname"
    t.string   "name"
    t.string   "patronymic"
    t.integer  "topic_id"
    t.string   "email"
    t.string   "phone"
    t.text     "text"
    t.boolean  "public"
    t.string   "answer_kind"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
    t.string   "code"
    t.string   "user_ip"
    t.string   "proxy_ip"
    t.string   "user_agent"
    t.string   "referrer"
    t.datetime "deleted_at"
    t.integer  "deleted_by_id"
    t.integer  "destroy_appeal_job_id"
    t.string   "social_status"
    t.integer  "section_id"
    t.string   "root_path"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "notes", :force => true do |t|
    t.boolean  "public"
    t.integer  "appeal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notes", ["appeal_id"], :name => "index_notes_on_appeal_id"

  create_table "redirects", :force => true do |t|
    t.string   "recipient"
    t.integer  "appeal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "redirects", ["appeal_id"], :name => "index_redirects_on_appeal_id"

  create_table "registrations", :force => true do |t|
    t.date     "registered_on"
    t.string   "number"
    t.integer  "appeal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "registrations", ["appeal_id"], :name => "index_registrations_on_appeal_id"

  create_table "replies", :force => true do |t|
    t.string   "number"
    t.date     "replied_on"
    t.text     "text"
    t.boolean  "public"
    t.string   "replied_by"
    t.integer  "appeal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", :force => true do |t|
    t.string   "recipient"
    t.integer  "appeal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["appeal_id"], :name => "index_reviews_on_appeal_id"

  create_table "sections", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "topics", :force => true do |t|
    t.text     "title"
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["section_id"], :name => "index_topics_on_section_id"

  create_table "uploads", :force => true do |t|
    t.integer  "uploadable_id"
    t.string   "file_name"
    t.string   "file_mime_type"
    t.integer  "file_size"
    t.string   "file_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uploadable_type"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.text     "sections"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
