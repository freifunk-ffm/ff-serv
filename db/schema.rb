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

ActiveRecord::Schema.define(:version => 20140128182906) do

  create_table "fastds", :force => true do |t|
    t.integer  "node_id",    :limit => 8
    t.string   "fw_version"
    t.string   "key"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "vpn_server"
  end

  create_table "lite_node_registrations", :force => true do |t|
    t.integer  "node_id"
    t.integer  "user_id"
    t.string   "standort",      :limit => 183
    t.string   "contact_mail",  :limit => 61
    t.string   "notice",        :limit => 181
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "latitude",                     :precision => 28, :scale => 13
    t.decimal  "longitude",                    :precision => 28, :scale => 14
    t.string   "node_name",     :limit => 50
    t.string   "operator_name", :limit => 50
  end

  create_table "lite_nodes", :force => true do |t|
    t.string   "user_id",    :limit => 50
    t.string   "position",   :limit => 50
    t.string   "bat0_mac",   :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "wlan_mac",   :limit => 50
    t.string   "status_id",  :limit => 50
    t.string   "current_ip", :limit => 50
  end

  create_table "lite_roles", :id => false, :force => true do |t|
    t.integer  "id"
    t.string   "name",       :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lite_tincs", :id => false, :force => true do |t|
    t.integer  "id"
    t.integer  "node_id"
    t.string   "approved_at", :limit => 56
    t.string   "approved_by", :limit => 50
    t.string   "cert_data",   :limit => 455
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rip",         :limit => 68
  end

  create_table "lite_users", :force => true do |t|
    t.string   "email",                  :limit => 54
    t.string   "encrypted_password",     :limit => 90
    t.string   "reset_password_token",   :limit => 50
    t.string   "reset_password_sent_at", :limit => 50
    t.string   "remember_created_at",    :limit => 56
    t.integer  "sign_in_count"
    t.string   "current_sign_in_at",     :limit => 56
    t.string   "last_sign_in_at",        :limit => 56
    t.string   "current_sign_in_ip",     :limit => 68
    t.string   "last_sign_in_ip",        :limit => 68
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
    t.string   "name",                   :limit => 50
    t.string   "confirmation_token",     :limit => 50
    t.string   "confirmed_at",           :limit => 56
    t.string   "confirmation_sent_at",   :limit => 56
    t.string   "unconfirmed_email",      :limit => 50
  end

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
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.text     "notice"
    t.string   "osm_loc"
    t.integer  "node_id",        :limit => 8
  end

  add_index "node_registrations", ["name"], :name => "index_registrations_on_name"
  add_index "node_registrations", ["node_id"], :name => "index_node_registrations_on_node_id"
  add_index "node_registrations", ["owner_id"], :name => "index_registrations_on_owner_id"

  create_table "node_status_histories", :force => true do |t|
    t.integer  "node_id"
    t.integer  "vpn_status_id"
    t.string   "fw_version"
    t.string   "initial_conf_version"
    t.string   "vpn_sw_name"
    t.datetime "created_at",           :null => false
    t.datetime "expired_at"
    t.string   "ip"
    t.string   "viewpoint"
    t.integer  "viewpoint_id"
  end

  add_index "node_status_histories", ["ip"], :name => "index_node_statuses_on_ip"
  add_index "node_status_histories", ["node_id"], :name => "index_node_statuses_on_node_id"
  add_index "node_status_histories", ["viewpoint"], :name => "index_node_statuses_on_viewpoint"
  add_index "node_status_histories", ["vpn_status_id"], :name => "index_node_statuses_on_vpn_status_id"

  create_table "node_statuses", :force => true do |t|
    t.integer  "node_id",              :limit => 8
    t.integer  "vpn_status_id"
    t.string   "fw_version"
    t.string   "initial_conf_version"
    t.string   "vpn_sw_name"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at"
    t.string   "ip"
    t.integer  "viewpoint_id"
  end

  add_index "node_statuses", ["ip"], :name => "index_node_statuses_on_ip"
  add_index "node_statuses", ["node_id"], :name => "index_node_statuses_on_node_id"
  add_index "node_statuses", ["viewpoint_id"], :name => "index_node_statuses_on_viewpoint_id"
  add_index "node_statuses", ["vpn_status_id"], :name => "index_node_statuses_on_vpn_status_id"

  create_table "nodes", :force => true do |t|
    t.string   "mac"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "fw_version"
  end

  add_index "nodes", ["mac"], :name => "index_nodes_on_mac"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "tincs", :force => true do |t|
    t.integer  "node_id",     :limit => 8
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

  create_table "viewpoints", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "vpn_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "watchdog_bites", :force => true do |t|
    t.integer  "node_id",         :limit => 8
    t.datetime "node_stmp"
    t.datetime "submission_stmp"
    t.text     "log_data"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "watchdog_bites", ["node_id"], :name => "index_watchdog_bites_on_node_id"
  add_index "watchdog_bites", ["node_stmp"], :name => "index_watchdog_bites_on_node_stmp"
  add_index "watchdog_bites", ["submission_stmp"], :name => "index_watchdog_bites_on_submission_stmp"

end
