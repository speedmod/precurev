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

ActiveRecord::Schema.define(version: 20131221174200) do

  create_table "arranger_links", force: true do |t|
    t.integer  "song_id",     null: false
    t.integer  "arranger_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "arrangers", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "character_links", force: true do |t|
    t.integer  "character_id", null: false
    t.integer  "song_id",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "characters", force: true do |t|
    t.string   "name",            null: false
    t.integer  "series_id"
    t.string   "prettycure_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "codes", force: true do |t|
    t.integer "song_id",                 null: false
    t.string  "maker"
    t.string  "machine"
    t.boolean "movie",   default: false
    t.string  "code",                    null: false
    t.string  "memo"
  end

  create_table "composer_links", force: true do |t|
    t.integer  "composer_id", null: false
    t.integer  "song_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "composers", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kana_links", force: true do |t|
    t.integer  "kana_id",    null: false
    t.integer  "song_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kanas", force: true do |t|
    t.string   "kana"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "song_id"
  end

  create_table "series", force: true do |t|
    t.string   "name"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "abbreviation"
  end

  create_table "songs", force: true do |t|
    t.string   "name",       null: false
    t.integer  "year"
    t.integer  "series_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "songdata"
  end

  create_table "vocalist_links", force: true do |t|
    t.integer  "vocalist_id", null: false
    t.integer  "song_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vocalists", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "writer_links", force: true do |t|
    t.integer  "writer_id",  null: false
    t.integer  "song_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "writers", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
