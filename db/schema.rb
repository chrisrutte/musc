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

ActiveRecord::Schema.define(version: 20160911084413) do

  create_table "add_new_fields_to_reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_add_new_fields_to_reviews_on_user_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "content"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "training_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.index ["training_id"], name: "index_photos_on_training_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "thrill_id"
    t.index ["thrill_id"], name: "index_reservations_on_thrill_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "comment"
    t.integer  "star"
    t.integer  "training_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.index ["training_id"], name: "index_reviews_on_training_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "thrills", force: :cascade do |t|
    t.integer  "training_id"
    t.date     "thrilldate"
    t.integer  "thrillhr"
    t.integer  "thrillmin"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.time     "time"
    t.index ["training_id"], name: "index_thrills_on_training_id"
  end

  create_table "trainings", force: :cascade do |t|
    t.string   "tr_type"
    t.string   "tr_intensity"
    t.text     "tr_description"
    t.string   "tr_location"
    t.string   "tr_time"
    t.integer  "tr_max_attendants"
    t.decimal  "tr_price",          precision: 5, scale: 2
    t.integer  "tr_duration"
    t.string   "tr_gender"
    t.boolean  "tr_active"
    t.integer  "user_id"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "tr_name"
    t.float    "latitude"
    t.float    "longitude"
    t.index ["user_id"], name: "index_trainings_on_user_id"
  end

  create_table "trsessions", force: :cascade do |t|
    t.integer  "training_id"
    t.date     "tr_date"
    t.integer  "tr_timehrs"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "tr_timemin"
    t.index ["training_id"], name: "index_trsessions_on_training_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "fullname"
    t.string   "phone_number"
    t.text     "description"
    t.string   "provider"
    t.string   "uid"
    t.string   "image"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
