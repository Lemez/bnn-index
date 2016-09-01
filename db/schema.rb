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

ActiveRecord::Schema.define(version: 14) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "daily_scores", force: :cascade do |t|
    t.float    "mail"
    t.float    "telegraph"
    t.float    "average"
    t.float    "guardian"
    t.float    "independent"
    t.float    "express"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "topics"
  end

  create_table "scores", force: :cascade do |t|
    t.datetime "date"
    t.float    "score"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stories", force: :cascade do |t|
    t.string   "title"
    t.float    "mixed"
    t.datetime "date"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "afinn"
    t.float    "wiebe"
    t.string   "method"
  end

  create_table "words", force: :cascade do |t|
    t.datetime "date"
    t.string   "lemma"
    t.integer  "score"
    t.integer  "storyid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "afinn"
    t.boolean  "wiebe"
    t.boolean  "jonlist"
  end

end
