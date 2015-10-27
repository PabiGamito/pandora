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

ActiveRecord::Schema.define(version: 20151024202820) do

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

  create_table "ads", force: true do |t|
    t.integer  "company_id"
    t.float    "amount"
    t.integer  "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "buildings", force: true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "break_date"
    t.datetime "updated_at"
  end

  create_table "buy_requests", force: true do |t|
    t.integer  "company_id"
    t.integer  "amount"
    t.boolean  "share"
    t.integer  "item_id"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.float    "share_price"
    t.boolean  "main"
    t.integer  "specialize"
    t.float    "production"
  end

  create_table "company_fees", force: true do |t|
    t.float   "fee"
    t.integer "company_id"
    t.integer "sector"
  end

  create_table "company_sectors", force: true do |t|
    t.integer "company_id"
    t.integer "owner_company_id"
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

  create_table "employe_names", force: true do |t|
    t.string  "name"
    t.boolean "first_name"
    t.string  "origin"
  end

  create_table "employee_trainings", force: true do |t|
    t.integer  "training_type"
    t.integer  "company_id"
    t.datetime "date"
  end

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
    t.string   "name"
    t.integer  "salery"
    t.boolean  "request"
    t.integer  "category"
    t.integer  "building_id"
  end

  create_table "forem_categories", force: true do |t|
    t.string   "name",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "position",   default: 0
  end

  add_index "forem_categories", ["slug"], name: "index_forem_categories_on_slug", unique: true

  create_table "forem_forums", force: true do |t|
    t.string  "name"
    t.text    "description"
    t.integer "category_id"
    t.integer "views_count", default: 0
    t.string  "slug"
    t.integer "position",    default: 0
  end

  add_index "forem_forums", ["slug"], name: "index_forem_forums_on_slug", unique: true

  create_table "forem_groups", force: true do |t|
    t.string "name"
  end

  add_index "forem_groups", ["name"], name: "index_forem_groups_on_name"

  create_table "forem_memberships", force: true do |t|
    t.integer "group_id"
    t.integer "member_id"
  end

  add_index "forem_memberships", ["group_id"], name: "index_forem_memberships_on_group_id"

  create_table "forem_moderator_groups", force: true do |t|
    t.integer "forum_id"
    t.integer "group_id"
  end

  add_index "forem_moderator_groups", ["forum_id"], name: "index_forem_moderator_groups_on_forum_id"

  create_table "forem_posts", force: true do |t|
    t.integer  "topic_id"
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reply_to_id"
    t.string   "state",       default: "pending_review"
    t.boolean  "notified",    default: false
  end

  add_index "forem_posts", ["reply_to_id"], name: "index_forem_posts_on_reply_to_id"
  add_index "forem_posts", ["state"], name: "index_forem_posts_on_state"
  add_index "forem_posts", ["topic_id"], name: "index_forem_posts_on_topic_id"
  add_index "forem_posts", ["user_id"], name: "index_forem_posts_on_user_id"

  create_table "forem_subscriptions", force: true do |t|
    t.integer "subscriber_id"
    t.integer "topic_id"
  end

  create_table "forem_topics", force: true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "locked",       default: false,            null: false
    t.boolean  "pinned",       default: false
    t.boolean  "hidden",       default: false
    t.datetime "last_post_at"
    t.string   "state",        default: "pending_review"
    t.integer  "views_count",  default: 0
    t.string   "slug"
  end

  add_index "forem_topics", ["forum_id"], name: "index_forem_topics_on_forum_id"
  add_index "forem_topics", ["slug"], name: "index_forem_topics_on_slug", unique: true
  add_index "forem_topics", ["state"], name: "index_forem_topics_on_state"
  add_index "forem_topics", ["user_id"], name: "index_forem_topics_on_user_id"

  create_table "forem_views", force: true do |t|
    t.integer  "user_id"
    t.integer  "viewable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count",             default: 0
    t.string   "viewable_type"
    t.datetime "current_viewed_at"
    t.datetime "past_viewed_at"
  end

  add_index "forem_views", ["updated_at"], name: "index_forem_views_on_updated_at"
  add_index "forem_views", ["user_id"], name: "index_forem_views_on_user_id"
  add_index "forem_views", ["viewable_id"], name: "index_forem_views_on_viewable_id"

  create_table "items", force: true do |t|
    t.string "name"
    t.float  "value"
    t.float  "price"
  end

  create_table "lenders", force: true do |t|
    t.integer  "company_id"
    t.float    "percentage"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "loan_id"
    t.float    "total_repayed"
    t.integer  "user_id"
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

  create_table "notifications", force: true do |t|
    t.integer "company_id"
    t.integer "user_id"
    t.boolean "global"
    t.string  "notification"
  end

  create_table "posts", force: true do |t|
    t.integer  "user_id"
    t.string   "post"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "sell_requests", force: true do |t|
    t.integer  "company_id"
    t.integer  "item_id"
    t.integer  "amount"
    t.boolean  "share"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shares", force: true do |t|
    t.integer "company_id"
    t.integer "company_owner_id"
    t.integer "user_owner_id"
    t.integer "shares"
  end

  create_table "stocks", force: true do |t|
    t.integer "company_id"
    t.integer "item_id"
    t.float   "amount"
    t.integer "storage_id"
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
    t.integer  "company_id"
    t.integer  "upgrade_value"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "upgrade_productions", force: true do |t|
    t.integer "max_employees"
    t.float   "speed_per_employee"
    t.integer "upgrade_id"
  end

  create_table "upgrade_recepies", force: true do |t|
    t.integer "upgrade_id"
    t.integer "item_id"
    t.integer "amount"
  end

  create_table "upgrades", force: true do |t|
    t.integer "value"
    t.integer "category"
    t.integer "level"
    t.integer "time"
    t.string  "name"
    t.integer "price"
    t.integer "headquarters_level"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",               null: false
    t.string   "encrypted_password",     default: "",               null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "username"
    t.float    "balance"
    t.string   "full_name"
    t.boolean  "premium"
    t.boolean  "forem_admin",            default: false
    t.string   "forem_state",            default: "pending_review"
    t.boolean  "forem_auto_subscribe",   default: false
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
