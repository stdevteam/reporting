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

ActiveRecord::Schema.define(version: 20181120080953) do

  create_table "appointments", force: :cascade do |t|
    t.string   "status"
    t.integer  "client_id"
    t.integer  "slot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_appointments_on_client_id"
    t.index ["slot_id"], name: "index_appointments_on_slot_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.string   "street_address"
    t.string   "country"
    t.string   "city"
    t.string   "zip_code"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.string   "referrer"
    t.float    "purchased_at_price"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "slot_variations", force: :cascade do |t|
    t.float    "price"
    t.integer  "slot_id"
    t.integer  "variation_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["slot_id"], name: "index_slot_variations_on_slot_id"
    t.index ["variation_id"], name: "index_slot_variations_on_variation_id"
  end

  create_table "slots", force: :cascade do |t|
    t.date     "begin_at"
    t.date     "end_at"
    t.integer  "location_id"
    t.integer  "purchase_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["location_id"], name: "index_slots_on_location_id"
    t.index ["purchase_id"], name: "index_slots_on_purchase_id"
  end

  create_table "variations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
