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

ActiveRecord::Schema.define(:version => 20111006093054) do

  create_table "addresses", :force => true do |t|
    t.integer  "postcode"
    t.string   "region"
    t.string   "district"
    t.string   "street"
    t.string   "house"
    t.string   "building"
    t.string   "flat"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "appeal_id"
  end

  create_table "appeals", :force => true do |t|
    t.string   "surname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "patronymic"
    t.integer  "topic_id"
    t.string   "email"
    t.string   "phone"
    t.text     "text"
    t.boolean  "public"
    t.string   "answer_kind"
  end

  create_table "sections", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", :force => true do |t|
    t.text     "title"
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "topics", ["section_id"], :name => "index_topics_on_section_id"

end
