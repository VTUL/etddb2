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

ActiveRecord::Schema.define(:version => 20120720194046) do

  create_table "availabilities", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.boolean  "retired"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "contents", :force => true do |t|
    t.boolean  "bound"
    t.string   "title"
    t.text     "description"
    t.text     "mime_type"
    t.integer  "etd_id"
    t.integer  "availability_id"
    t.integer  "page_count"
    t.integer  "duration"
    t.string   "dimensions"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "content_file_name"
    t.string   "content_content_type"
    t.integer  "content_file_size"
    t.datetime "content_updated_at"
  end

  create_table "conversations", :force => true do |t|
    t.string   "subject",    :default => ""
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "copyright_statements", :force => true do |t|
    t.string   "statement"
    t.boolean  "retired"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "degrees", :force => true do |t|
    t.string   "name"
    t.boolean  "retired"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.boolean  "retired"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "departments_etds", :id => false, :force => true do |t|
    t.integer "etd_id"
    t.integer "department_id"
  end

  create_table "digital_objects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "document_types", :force => true do |t|
    t.string   "name"
    t.boolean  "retired"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "notifications", :force => true do |t|
    t.string   "type"
    t.text     "body"
    t.string   "subject",              :default => ""
    t.integer  "sender_id"
    t.string   "sender_type"
    t.integer  "conversation_id"
    t.boolean  "draft",                :default => false
    t.datetime "updated_at",                              :null => false
    t.datetime "created_at",                              :null => false
    t.integer  "notified_object_id"
    t.string   "notified_object_type"
    t.string   "notification_code"
    t.string   "attachment"
  end

  add_index "notifications", ["conversation_id"], :name => "index_notifications_on_conversation_id"

  create_table "people", :force => true do |t|
    t.string   "pid"
    t.string   "title"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "suffix"
    t.string   "display_name"
    t.string   "email"
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
    t.boolean  "show_email"
  end

  add_index "people", ["email"], :name => "index_people_on_email", :unique => true
  add_index "people", ["pid"], :name => "index_people_on_pid", :unique => true
  add_index "people", ["reset_password_token"], :name => "index_people_on_reset_password_token", :unique => true

  create_table "people_roles", :force => true do |t|
    t.integer "person_id"
    t.integer "role_id"
    t.integer "etd_id"
    t.boolean "vote"
  end

  add_index "people_roles", ["etd_id"], :name => "index_people_roles_on_etd_id"
  add_index "people_roles", ["person_id", "role_id", "etd_id"], :name => "index_people_roles_on_person_id_and_role_id_and_etd_id", :unique => true
  add_index "people_roles", ["role_id"], :name => "index_people_roles_on_role_id"

  create_table "permissions", :force => true do |t|
    t.integer  "user_action_id"
    t.integer  "role_id"
    t.integer  "digital_object_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "privacy_statements", :force => true do |t|
    t.string   "statement"
    t.boolean  "retired"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "provenances", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "person_id"
    t.integer  "model_id"
    t.string   "model_type"
    t.string   "action"
    t.string   "message"
  end

  create_table "receipts", :force => true do |t|
    t.integer  "receiver_id"
    t.string   "receiver_type"
    t.integer  "notification_id",                                  :null => false
    t.boolean  "read",                          :default => false
    t.boolean  "trashed",                       :default => false
    t.boolean  "deleted",                       :default => false
    t.string   "mailbox_type",    :limit => 25
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "receipts", ["notification_id"], :name => "index_receipts_on_notification_id"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.string   "group"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_actions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
