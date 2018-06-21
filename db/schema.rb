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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170818071413) do

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "follows", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "follows", ["followed_id"], name: "index_follows_on_followed_id"
  add_index "follows", ["follower_id", "followed_id"], name: "index_follows_on_follower_id_and_followed_id", unique: true
  add_index "follows", ["follower_id"], name: "index_follows_on_follower_id"

  create_table "impressions", force: :cascade do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.text     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id"

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messengers", force: :cascade do |t|
    t.string   "content"
    t.string   "title"
    t.string   "sender_email"
    t.string   "recever_email"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "mpcomments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "musicpost_id"
    t.text     "content"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "mplikes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "musicpost_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "musicposts", force: :cascade do |t|
    t.string   "title"
    t.string   "musictype"
    t.string   "content"
    t.string   "music"
    t.string   "image"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "playlists", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "musicpost_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.string   "musictype"
    t.string   "content"
    t.string   "requirement"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "image"
    t.string   "music"
  end

  create_table "receivemessengers", force: :cascade do |t|
    t.string   "content"
    t.string   "title"
    t.string   "sender_email"
    t.string   "recever_email"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "teamcomments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teammembers", force: :cascade do |t|
    t.integer  "member_id"
    t.boolean  "granted",    default: false
    t.boolean  "waiting",    default: true
    t.integer  "team_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "teams", force: :cascade do |t|
    t.integer  "leader_id"
    t.integer  "post_id"
    t.boolean  "ongoing",    default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "name"
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
    t.string   "avatar"
    t.string   "provider"
    t.string   "uid"
    t.string   "image"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
