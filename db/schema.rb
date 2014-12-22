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

ActiveRecord::Schema.define(version: 20141215074114) do

  create_table "amounts", force: true do |t|
    t.string   "type"
    t.integer  "wallet_id"
    t.integer  "entry_id"
    t.decimal  "amount",     precision: 20, scale: 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "amounts", ["entry_id"], name: "index_amounts_on_entry_id"
  add_index "amounts", ["wallet_id"], name: "index_amounts_on_wallet_id"

  create_table "entries", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "owners", force: true do |t|
    t.string   "name"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wallets", force: true do |t|
    t.integer  "owner_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wallets", ["owner_id"], name: "index_wallets_on_owner_id"

end
