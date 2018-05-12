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

ActiveRecord::Schema.define(version: 2018_05_12_053352) do

  create_table "certificates", force: :cascade do |t|
    t.string "url"
    t.date "expiration"
    t.integer "load_balancer_id"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["load_balancer_id"], name: "index_certificates_on_load_balancer_id"
  end

  create_table "ciphers", force: :cascade do |t|
    t.string "name"
    t.boolean "secure", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "load_balancers", force: :cascade do |t|
    t.string "hostname"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
