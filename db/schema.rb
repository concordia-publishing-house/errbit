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

ActiveRecord::Schema.define(version: 20180830151045) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apps", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "api_key",                limit: 255
    t.string   "github_repo",            limit: 255
    t.string   "bitbucket_repo",         limit: 255
    t.string   "asset_host",             limit: 255
    t.string   "repository_branch",      limit: 255
    t.boolean  "resolve_errs_on_deploy",             default: false
    t.boolean  "notify_all_users",                   default: false
    t.boolean  "notify_on_errs",                     default: true
    t.boolean  "notify_on_deploys",                  default: false
    t.text     "email_at_notices"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  create_table "backtrace_lines", force: :cascade do |t|
    t.integer  "backtrace_id"
    t.integer  "column"
    t.integer  "number"
    t.text     "file"
    t.text     "method"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["backtrace_id"], name: "index_backtrace_lines_on_backtrace_id", using: :btree
  end

  create_table "backtraces", force: :cascade do |t|
    t.string   "fingerprint", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["fingerprint"], name: "index_backtraces_on_fingerprint", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "problem_id"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "err_id"
    t.index ["err_id"], name: "index_comments_on_err_id", using: :btree
    t.index ["problem_id"], name: "index_comments_on_problem_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "deploys", force: :cascade do |t|
    t.string   "username",    limit: 255
    t.string   "repository",  limit: 255
    t.string   "environment", limit: 255
    t.string   "revision",    limit: 255
    t.string   "message",     limit: 255
    t.integer  "app_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["app_id"], name: "index_deploys_on_app_id", using: :btree
  end

  create_table "errs", force: :cascade do |t|
    t.integer  "problem_id"
    t.string   "fingerprint", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["fingerprint"], name: "index_errs_on_fingerprint", using: :btree
    t.index ["problem_id"], name: "index_errs_on_problem_id", using: :btree
  end

  create_table "issue_trackers", force: :cascade do |t|
    t.integer  "app_id"
    t.string   "project_id",        limit: 255
    t.string   "alt_project_id",    limit: 255
    t.string   "api_token",         limit: 255
    t.string   "type",              limit: 255
    t.string   "account",           limit: 255
    t.string   "username",          limit: 255
    t.string   "password",          limit: 255
    t.string   "ticket_properties", limit: 255
    t.string   "subdomain",         limit: 255
    t.string   "milestone_id",      limit: 255
    t.string   "base_url",          limit: 255
    t.string   "context_path",      limit: 255
    t.string   "issue_type",        limit: 255
    t.string   "issue_component",   limit: 255
    t.string   "issue_priority",    limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["app_id"], name: "index_issue_trackers_on_app_id", using: :btree
  end

  create_table "notices", force: :cascade do |t|
    t.integer  "err_id"
    t.integer  "backtrace_id"
    t.text     "message"
    t.text     "server_environment"
    t.text     "request"
    t.text     "notifier"
    t.text     "user_attributes"
    t.string   "framework",          limit: 255
    t.text     "current_user"
    t.string   "error_class",        limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "host",               limit: 255
    t.string   "user_agent_string",  limit: 255
    t.index ["backtrace_id"], name: "index_notices_on_backtrace_id", using: :btree
    t.index ["err_id", "created_at", "id"], name: "index_notices_on_err_id_and_created_at_and_id", using: :btree
  end

  create_table "notification_services", force: :cascade do |t|
    t.integer  "app_id"
    t.string   "room_id",           limit: 255
    t.string   "user_id",           limit: 255
    t.string   "service_url",       limit: 255
    t.string   "service",           limit: 255
    t.string   "api_token",         limit: 255
    t.string   "subdomain",         limit: 255
    t.string   "sender_name",       limit: 255
    t.string   "type",              limit: 255
    t.text     "notify_at_notices"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["app_id"], name: "index_notification_services_on_app_id", using: :btree
  end

  create_table "problems", force: :cascade do |t|
    t.integer  "app_id"
    t.datetime "last_notice_at"
    t.datetime "first_notice_at"
    t.datetime "last_deploy_at"
    t.boolean  "resolved"
    t.datetime "resolved_at"
    t.string   "issue_link",               limit: 255
    t.string   "issue_type",               limit: 255
    t.string   "app_name",                 limit: 255
    t.integer  "notices_count"
    t.integer  "comments_count"
    t.text     "message"
    t.string   "environment",              limit: 255
    t.text     "error_class"
    t.string   "where",                    limit: 255
    t.text     "user_agents"
    t.text     "messages"
    t.text     "hosts"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "first_notice_commit",      limit: 255
    t.string   "last_notice_commit",       limit: 255
    t.string   "first_notice_environment", limit: 255
    t.string   "last_notice_environment",  limit: 255
    t.datetime "opened_at",                            null: false
    t.datetime "deleted_at"
    t.index ["app_id"], name: "index_problems_on_app_id", using: :btree
    t.index ["app_name"], name: "index_problems_on_app_name", using: :btree
    t.index ["comments_count"], name: "index_problems_on_comments_count", using: :btree
    t.index ["first_notice_at"], name: "index_problems_on_first_notice_at", using: :btree
    t.index ["last_notice_at"], name: "index_problems_on_last_notice_at", using: :btree
    t.index ["notices_count"], name: "index_problems_on_notices_count", using: :btree
    t.index ["resolved_at"], name: "index_problems_on_resolved_at", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "github_login",           limit: 255
    t.string   "github_oauth_token",     limit: 255
    t.string   "name",                   limit: 255
    t.string   "username",               limit: 255
    t.boolean  "admin"
    t.integer  "per_page"
    t.string   "time_zone",              limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "authentication_token",   limit: 255
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "watchers", force: :cascade do |t|
    t.integer  "app_id"
    t.integer  "user_id"
    t.string   "email",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["app_id"], name: "index_watchers_on_app_id", using: :btree
    t.index ["user_id"], name: "index_watchers_on_user_id", using: :btree
  end

end
