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

ActiveRecord::Schema.define(:version => 20121021123352) do

  create_table "node_registrations", :force => true do |t|
    t.string   "name"
    t.string   "operator_name"
    t.string   "operator_email"
    t.string   "loc_str"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "owner_id"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.text     "notice"
    t.string   "osm_loc"
  end

  add_index "node_registrations", ["name"], :name => "index_registrations_on_name"
  add_index "node_registrations", ["owner_id"], :name => "index_registrations_on_owner_id"

  create_table "node_statuses", :force => true do |t|
    t.integer  "node_id"
    t.integer  "vpn_status_id"
    t.string   "fw_version"
    t.string   "initial_conf_version"
    t.string   "vpn_sw_name"
    t.datetime "created_at",           :null => false
    t.datetime "expired_at"
    t.string   "ip"
  end

  add_index "node_statuses", ["ip"], :name => "index_node_statuses_on_ip"
  add_index "node_statuses", ["node_id"], :name => "index_node_statuses_on_node_id"
  add_index "node_statuses", ["vpn_status_id"], :name => "index_node_statuses_on_vpn_status_id"

  create_table "nodes", :force => true do |t|
    t.string   "mac"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "node_registration_id"
  end

  add_index "nodes", ["mac"], :name => "index_nodes_on_mac"
  add_index "nodes", ["node_registration_id"], :name => "index_nodes_on_registration_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "tincs", :force => true do |t|
    t.integer  "node_id"
    t.datetime "approved_at"
    t.integer  "approved_by"
    t.datetime "revoked_at"
    t.integer  "revoked_by"
    t.string   "ip_address",  :limit => 63
    t.string   "certfp"
    t.text     "cert_data"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "tincs", ["approved_at"], :name => "index_tincs_on_approved_at"
  add_index "tincs", ["certfp"], :name => "index_tincs_on_certfp"
  add_index "tincs", ["node_id"], :name => "index_tincs_on_node_id"
  add_index "tincs", ["revoked_at"], :name => "index_tincs_on_revoked_at"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "role_id"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["role_id"], :name => "index_users_on_role_id"

  create_table "vpn_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
