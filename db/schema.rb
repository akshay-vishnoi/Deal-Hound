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

ActiveRecord::Schema.define(:version => 20120914112359) do

  create_table "addresses", :force => true do |t|
    t.text     "street"
    t.string   "city"
    t.string   "state"
    t.integer  "pincode"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "carts", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "commodities", :force => true do |t|
    t.integer  "category_id"
    t.string   "title"
    t.text     "features"
    t.text     "description"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "vendor"
    t.integer  "voucher"
    t.integer  "actual_price",  :limit => 2
    t.integer  "selling_price", :limit => 2
  end

  create_table "commodity_skus", :force => true do |t|
    t.integer  "quantity"
    t.string   "color"
    t.string   "size"
    t.integer  "commodity_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "images", :force => true do |t|
    t.integer  "snapshot_id"
    t.string   "snapshot_type"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "line_items", :force => true do |t|
    t.integer  "commodity_sku_id"
    t.integer  "cart_id"
    t.integer  "quantity"
    t.integer  "order_id"
    t.integer  "price",            :limit => 2
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.string   "mailing_email"
    t.integer  "status"
    t.integer  "payment_mode"
    t.integer  "gift"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "full_name"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "mobile_no"
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
    t.integer  "admin",                                         :default => 0
    t.decimal  "wallet",          :precision => 2, :scale => 0, :default => 0
    t.string   "user_name"
  end

  create_table "vouchers", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.text     "redeem_procedure"
    t.date     "redeem_within"
    t.integer  "commodity_id"
    t.datetime "created_at",                                                    :null => false
    t.datetime "updated_at",                                                    :null => false
    t.decimal  "discount",         :precision => 2, :scale => 0, :default => 0
  end

end
