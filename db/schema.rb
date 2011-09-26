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

ActiveRecord::Schema.define(:version => 20110420190416) do

  create_table "actions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "actions_roles_digital_objects", :id => false, :force => true do |t|
    t.integer "action_id"
    t.integer "role_id"
    t.integer "digital_object_id"
  end

  add_index "actions_roles_digital_objects", ["action_id"], :name => "index_actions_roles_digital_objects_on_action_id"
  add_index "actions_roles_digital_objects", ["digital_object_id"], :name => "index_actions_roles_digital_objects_on_digital_object_id"
  add_index "actions_roles_digital_objects", ["role_id", "action_id", "digital_object_id"], :name => "index_actions_roles_digital_objects", :unique => true

  create_table "availability_descriptions", :force => true do |t|
    t.integer  "etd_id"
    t.string   "availability"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contents", :force => true do |t|
    t.integer  "etd_id"
    t.string   "uploaded_file_name"
    t.string   "uploaded_content_type"
    t.integer  "uploaded_file_size"
    t.datetime "uploaded_updated_at"
    t.string   "availability"
    t.string   "bound"
    t.integer  "page_count"
    t.datetime "timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "file_id"
    t.string   "file_type"
  end

  create_table "copyright_statements", :force => true do |t|
    t.integer  "etd_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "degree_descriptions", :force => true do |t|
    t.integer  "etd_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", :force => true do |t|
    t.integer  "etd_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "digital_objects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "doc_type_descriptions", :force => true do |t|
    t.integer  "etd_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "etds", :force => true do |t|
    t.string   "urn"
    t.string   "degree"
    t.string   "department"
    t.string   "dtype"
    t.text     "title"
    t.text     "abstract"
    t.string   "availability"
    t.text     "availability_description"
    t.text     "copyright_statement"
    t.date     "ddate"
    t.date     "sdate"
    t.date     "adate"
    t.date     "cdate"
    t.date     "rdate"
    t.string   "pid"
    t.string   "url"
    t.datetime "timestamp"
    t.string   "bound"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "committee_chair_id"
    t.integer  "author_id"
  end

  create_table "etds_people", :id => false, :force => true do |t|
    t.integer "etd_id"
    t.integer "person_id"
  end

  add_index "etds_people", ["etd_id", "person_id"], :name => "index_etds_people_on_etd_id_and_person_id", :unique => true
  add_index "etds_people", ["person_id"], :name => "index_etds_people_on_person_id"

  create_table "keywords", :force => true do |t|
    t.integer  "etd_id"
    t.string   "word"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", :force => true do |t|
    t.string   "role"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "pid"
    t.string   "suffix"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "roles_mask"
  end

  create_table "people_roles", :force => true do |t|
    t.integer "person_id"
    t.integer "role_id"
    t.integer "etd_id"
  end

  add_index "people_roles", ["etd_id"], :name => "index_people_roles_on_etd_id"
  add_index "people_roles", ["person_id", "role_id", "etd_id"], :name => "index_people_roles_on_person_id_and_role_id_and_etd_id", :unique => true
  add_index "people_roles", ["role_id"], :name => "index_people_roles_on_role_id"

  create_table "permissions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "action_id"
    t.integer  "role_id"
    t.integer  "digital_object_id"
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

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "urns", :force => true do |t|
    t.string   "urn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
