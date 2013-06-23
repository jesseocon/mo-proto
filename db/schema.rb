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

ActiveRecord::Schema.define(:version => 20130622165626) do

  create_table "albums", :force => true do |t|
    t.string    "name"
    t.string    "album_handle"
    t.integer   "user_id"
    t.timestamp "created_at",   :null => false
    t.timestamp "updated_at",   :null => false
  end

  add_index "albums", ["album_handle"], :name => "index_albums_on_album_handle"
  add_index "albums", ["name"], :name => "index_albums_on_name"
  add_index "albums", ["user_id"], :name => "index_albums_on_user_id"

  create_table "charges", :force => true do |t|
    t.integer   "amount"
    t.integer   "folio_id"
    t.integer   "user_id"
    t.timestamp "created_at",       :null => false
    t.timestamp "updated_at",       :null => false
    t.integer   "package_id"
    t.string    "stripe_charge_id"
    t.integer   "limit"
  end

  add_index "charges", ["folio_id"], :name => "index_charges_on_folio_id"
  add_index "charges", ["stripe_charge_id"], :name => "index_charges_on_stripe_charge_id", :unique => true
  add_index "charges", ["user_id"], :name => "index_charges_on_user_id"

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "contacts", ["email"], :name => "index_contacts_on_email"
  add_index "contacts", ["user_id", "email"], :name => "index_contacts_on_user_id_and_email", :unique => true
  add_index "contacts", ["user_id"], :name => "index_contacts_on_user_id"

  create_table "folios", :force => true do |t|
    t.string    "name"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
    t.integer   "package_id"
    t.string    "keyword"
    t.integer   "user_id"
  end

  add_index "folios", ["user_id"], :name => "index_folios_on_user_id"

  create_table "incoming_messages", :force => true do |t|
    t.string    "from"
    t.string    "to"
    t.string    "photo_file_name"
    t.string    "photo_content_type"
    t.integer   "photo_file_size"
    t.timestamp "photo_updated_at"
    t.timestamp "created_at",         :null => false
    t.timestamp "updated_at",         :null => false
    t.integer   "album_id"
    t.integer   "width"
    t.integer   "height"
  end

  add_index "incoming_messages", ["album_id"], :name => "index_incoming_messages_on_album_id"

  create_table "invitations", :force => true do |t|
    t.integer  "album_id"
    t.string   "user_email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "invitations", ["album_id", "user_email"], :name => "index_invitations_on_album_id_and_user_email", :unique => true

  create_table "messages", :force => true do |t|
    t.timestamp "created_at",  :null => false
    t.timestamp "updated_at",  :null => false
    t.string    "campaign_id"
    t.string    "msisdn"
    t.string    "carrier"
    t.text      "message"
    t.string    "image_url"
  end

  create_table "packages", :force => true do |t|
    t.string    "name"
    t.decimal   "price"
    t.integer   "photo_qty"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  create_table "stars", :force => true do |t|
    t.integer   "user_id"
    t.integer   "incoming_message_id"
    t.timestamp "created_at",          :null => false
    t.timestamp "updated_at",          :null => false
  end

  add_index "stars", ["incoming_message_id"], :name => "index_stars_on_incoming_message_id"
  add_index "stars", ["user_id", "incoming_message_id"], :name => "index_stars_on_user_id_and_incoming_message_id", :unique => true
  add_index "stars", ["user_id"], :name => "index_stars_on_user_id"

  create_table "users", :force => true do |t|
    t.string    "email"
    t.string    "password_digest"
    t.string    "auth_token"
    t.string    "password_reset_token"
    t.timestamp "password_reset_at"
    t.string    "verification_token"
    t.boolean   "verified"
    t.boolean   "admin"
    t.timestamp "created_at",           :null => false
    t.timestamp "updated_at",           :null => false
    t.string    "phone"
    t.string    "name"
    t.string    "last_4_digits"
    t.string    "stripe_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["verification_token"], :name => "index_users_on_verification_token"

end
