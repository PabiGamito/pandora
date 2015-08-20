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

ActiveRecord::Schema.define(version: 20150819181015) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: true do |t|
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
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "companies", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "moto"
    t.integer  "employes"
    t.float    "balance"
    t.float    "sales_turnover"
    t.float    "expenses"
    t.float    "market_capita"
    t.boolean  "market"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "income"
    t.integer  "sector"
    t.integer  "shares"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "employes", force: true do |t|
    t.integer  "company_id"
    t.float    "iq"
    t.integer  "efficiency"
    t.integer  "focus"
    t.string   "quality"
    t.integer  "happiness"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
    t.string   "name"
    t.integer  "salery"
  end

  create_table "lenders", force: true do |t|
    t.integer  "company_id"
    t.float    "percentage"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "loan_id"
    t.float    "total_repayed"
  end

  create_table "loans", force: true do |t|
    t.integer  "lender_id"
    t.integer  "receiver_id"
    t.float    "amount"
    t.float    "pending"
    t.integer  "repay_time"
    t.float    "rate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "total_repayed"
    t.boolean  "max"
  end

  create_table "posts", force: true do |t|
    t.integer  "user_id"
    t.string   "post"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "shares", force: true do |t|
    t.integer "company_id"
    t.integer "company_owner_id"
    t.integer "user_owner_id"
    t.integer "shares"
  end

  create_table "transactions", force: true do |t|
    t.string   "description"
    t.string   "from"
    t.integer  "company_id"
    t.boolean  "income"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "amount"
    t.integer  "user_id"
    t.string   "category"
  end

  create_table "updates", force: true do |t|
    t.integer  "user_id"
    t.integer  "company_id"
    t.string   "message"
    t.datetime "created_at"
  end

  create_table "upgrade_levels", force: true do |t|
    t.integer "company_id"
    t.integer "upgrade_value"
    t.integer "level"
  end

  create_table "upgrades", force: true do |t|
    t.string  "description"
    t.integer "value"
  end

  create_table "users", force: true do |t|
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
    t.string   "username"
    t.float    "balance"
    t.string   "full_name"
    t.boolean  "premium"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

  create_table "votes", force: true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"

end
