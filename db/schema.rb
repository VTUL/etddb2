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

ActiveRecord::Schema.define(:version => 20120126205621) do

  create_table "availabilities", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "retired"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contents", :force => true do |t|
    t.string   "uploaded_file_name"
    t.string   "uploaded_content_type"
    t.integer  "uploaded_file_size"
    t.datetime "uploaded_updated_at"
    t.boolean  "bound"
    t.string   "title"
    t.text     "description"
    t.integer  "etd_id"
    t.integer  "availability_id"
    t.integer  "page_count"
    t.integer  "duration"
    t.string   "dimensions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "copyright_statements", :force => true do |t|
    t.string   "description"
    t.boolean  "retired"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "degrees", :force => true do |t|
    t.string   "name"
    t.boolean  "retired"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.boolean  "retired"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments_etds", :id => false, :force => true do |t|
    t.integer "etd_id"
    t.integer "department_id"
  end

  create_table "digital_objects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "document_types", :force => true do |t|
    t.string   "name"
    t.boolean  "retired"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "etds", :force => true do |t|
    t.text     "title"
    t.text     "abstract"
    t.boolean  "bound"
    t.text     "keywords"
    t.string   "status"
    t.string   "urn"
    t.string   "url"
    t.date     "ddate"
    t.date     "sdate"
    t.date     "adate"
    t.date     "cdate"
    t.date     "rdate"
    t.integer  "availability_id"
    t.integer  "copyright_statement_id"
    t.integer  "degree_id"
    t.integer  "document_type_id"
    t.integer  "privacy_statement_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "pid"
    t.string   "title"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "suffix"
    t.string   "display_name"
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "people", ["email"], :name => "index_people_on_email", :unique => true
  add_index "people", ["pid"], :name => "index_people_on_pid", :unique => true
  add_index "people", ["reset_password_token"], :name => "index_people_on_reset_password_token", :unique => true

  create_table "people_roles", :force => true do |t|
    t.integer "person_id"
    t.integer "role_id"
    t.integer "etd_id"
  end

  add_index "people_roles", ["etd_id"], :name => "index_people_roles_on_etd_id"
  add_index "people_roles", ["person_id", "role_id", "etd_id"], :name => "index_people_roles_on_person_id_and_role_id_and_etd_id", :unique => true
  add_index "people_roles", ["role_id"], :name => "index_people_roles_on_role_id"

  create_table "permissions", :force => true do |t|
    t.integer  "user_action_id"
    t.integer  "role_id"
    t.integer  "digital_object_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "privacy_statements", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "retired"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "provenances", :force => true do |t|
    t.integer  "etd_id"
    t.string   "creator"
    t.string   "notice"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_actions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
