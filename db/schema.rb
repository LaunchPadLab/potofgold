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

ActiveRecord::Schema.define(:version => 20121211165819) do

  create_table "advertisers", :force => true do |t|
    t.string   "username"
    t.string   "uid"
    t.string   "image_url"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "business_name"
    t.string   "background_image_url"
  end

  create_table "coupons", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "redeemed"
    t.integer  "deal_id"
    t.integer  "followers"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "referred"
    t.string   "tweet"
  end

  create_table "deals", :force => true do |t|
    t.integer  "advertiser_id"
    t.datetime "end_date"
    t.text     "coupon_text"
    t.string   "sample_tweet"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.text     "description"
    t.integer  "image_id"
  end

  create_table "images", :force => true do |t|
    t.string   "image_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "uid"
    t.string   "image_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
