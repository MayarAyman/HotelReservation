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

ActiveRecord::Schema.define(version: 2018_10_07_174834) do

  create_table "availables", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.date "starting_date"
    t.date "ending_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "room_id"
    t.index ["room_id"], name: "index_availables_on_room_id"
  end

  create_table "reservations", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.date "checkin_date"
    t.date "checkout_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "room_id"
    t.index ["room_id"], name: "index_reservations_on_room_id"
  end

  create_table "rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "room_number"
    t.integer "room_capacity"
    t.string "roomtype"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "availables", "rooms"
  add_foreign_key "reservations", "rooms"
end
