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

ActiveRecord::Schema.define(version: 2019_08_08_140415) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "work_orders", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "deadline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "work_orders_workers", force: :cascade do |t|
    t.integer "work_order_id", null: false
    t.integer "worker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["work_order_id", "worker_id"], name: "worker_orders_workers_by_keys", unique: true
  end

  create_table "workers", force: :cascade do |t|
    t.string "name"
    t.string "company_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
