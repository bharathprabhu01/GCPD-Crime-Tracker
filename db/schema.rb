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

ActiveRecord::Schema.define(version: 20180814220554) do

  create_table "assignments", force: :cascade do |t|
    t.integer "investigation_id"
    t.integer "officer_id"
    t.date "start_date"
    t.date "end_date"
    t.index ["investigation_id"], name: "index_assignments_on_investigation_id"
    t.index ["officer_id"], name: "index_assignments_on_officer_id"
  end

  create_table "crime_investigations", force: :cascade do |t|
    t.integer "crime_id"
    t.integer "investigation_id"
    t.index ["crime_id"], name: "index_crime_investigations_on_crime_id"
    t.index ["investigation_id"], name: "index_crime_investigations_on_investigation_id"
  end

  create_table "crimes", force: :cascade do |t|
    t.string "name"
    t.boolean "felony", default: true
    t.boolean "active", default: true
  end

  create_table "criminals", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "aka"
    t.boolean "convicted_felon", default: false
    t.boolean "enhanced_powers", default: false
    t.text "notes"
  end

  create_table "investigation_notes", force: :cascade do |t|
    t.integer "investigation_id"
    t.integer "officer_id"
    t.text "content"
    t.date "date"
    t.index ["investigation_id"], name: "index_investigation_notes_on_investigation_id"
    t.index ["officer_id"], name: "index_investigation_notes_on_officer_id"
  end

  create_table "investigations", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "crime_location"
    t.date "date_opened"
    t.date "date_closed"
    t.boolean "solved", default: false
    t.boolean "batman_involved", default: false
  end

  create_table "officers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "unit_id"
    t.string "rank"
    t.string "ssn"
    t.boolean "active", default: true
    t.integer "user_id"
    t.index ["unit_id"], name: "index_officers_on_unit_id"
  end

  create_table "suspects", force: :cascade do |t|
    t.integer "investigation_id"
    t.integer "criminal_id"
    t.date "added_on"
    t.date "dropped_on"
    t.index ["criminal_id"], name: "index_suspects_on_criminal_id"
    t.index ["investigation_id"], name: "index_suspects_on_investigation_id"
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: true
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "role"
    t.string "password_digest"
    t.boolean "active"
  end

end
