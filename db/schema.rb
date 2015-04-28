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

ActiveRecord::Schema.define(version: 20150428232314) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chats", force: true do |t|
    t.integer  "user_id"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "conversation_id"
    t.datetime "deleted_at"
  end

  add_index "chats", ["conversation_id"], name: "index_chats_on_conversation_id", using: :btree

  create_table "conversations", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "conversations", ["user_id"], name: "index_conversations_on_user_id", using: :btree

  create_table "conversations_users", force: true do |t|
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "read_at"
    t.datetime "deleted_at"
  end

  add_index "conversations_users", ["conversation_id", "user_id"], name: "index_conversations_users_on_conversation_id_and_user_id", unique: true, using: :btree

  create_table "forums", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "category_id"
  end

  add_index "forums", ["slug"], name: "index_forums_on_slug", unique: true, using: :btree
  add_index "forums", ["title"], name: "index_forums_on_title", unique: true, using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "posts", force: true do |t|
    t.integer  "submission_id"
    t.integer  "author_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "thanks_count"
  end

  add_index "posts", ["deleted_at"], name: "index_posts_on_deleted_at", using: :btree

  create_table "submissions", force: true do |t|
    t.string   "title"
    t.integer  "author_id"
    t.integer  "forum_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "locked"
    t.string   "slug"
    t.integer  "posts_count", default: 0
    t.datetime "deleted_at"
    t.boolean  "secret"
  end

  add_index "submissions", ["deleted_at"], name: "index_submissions_on_deleted_at", using: :btree
  add_index "submissions", ["slug"], name: "index_submissions_on_slug", unique: true, using: :btree

  create_table "thanks", force: true do |t|
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "thanks", ["deleted_at"], name: "index_thanks_on_deleted_at", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                     default: "",                null: false
    t.string   "encrypted_password",        default: "",                null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0,                 null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "slug"
    t.string   "time_zone"
    t.string   "country"
    t.string   "title",                     default: "Registered User"
    t.text     "signature"
    t.string   "location"
    t.string   "avatar_url"
    t.string   "agent"
    t.datetime "deleted_at"
    t.boolean  "whats_new_default"
    t.boolean  "force_chat"
    t.integer  "gender",                    default: 1
    t.datetime "last_activity"
    t.string   "role"
    t.boolean  "conversation_notification", default: true
    t.integer  "profile_views",             default: 0
  end

  add_index "users", ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "views", force: true do |t|
    t.integer  "submission_id"
    t.integer  "user_id"
    t.datetime "viewed_at"
    t.datetime "deleted_at"
  end

  add_index "views", ["deleted_at"], name: "index_views_on_deleted_at", using: :btree
  add_index "views", ["submission_id"], name: "index_views_on_submission_id", using: :btree
  add_index "views", ["user_id"], name: "index_views_on_user_id", using: :btree

end
