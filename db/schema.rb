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

ActiveRecord::Schema.define(:version => 20130316234827) do

  create_table "clients", :force => true do |t|
    t.string   "name"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.integer  "zip"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "clients", ["name"], :name => "index_clients_on_name"

  create_table "jobs", :force => true do |t|
    t.string   "name"
    t.boolean  "is_bid"
    t.boolean  "is_billed"
    t.boolean  "is_paid"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "jobs", ["name"], :name => "index_jobs_on_name"

  create_table "work_categories", :force => true do |t|
    t.string   "name"
    t.decimal  "price_per_unit"
    t.string   "unit"
    t.decimal  "labor_time_per_unit"
    t.boolean  "is_taxable"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "work_categories", ["name"], :name => "index_work_categories_on_name"

  create_table "work_items", :force => true do |t|
    t.integer  "work_category_id"
    t.integer  "work_amount"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "job_id"
  end

end
