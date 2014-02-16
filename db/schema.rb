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

ActiveRecord::Schema.define(version: 20140216074048) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pod_libraries", force: true do |t|
    t.string   "name"
    t.string   "homepage"
    t.string   "social_media_url"
    t.string   "documentation_url"
    t.string   "summary"
    t.text     "description"
    t.string   "git_source"
    t.string   "git_tag"
    t.string   "current_version"
    t.datetime "current_version_released_at"
    t.datetime "first_version_released_at"
    t.integer  "github_watcher_count",        default: 0,   null: false
    t.integer  "github_stargazer_count",      default: 0,   null: false
    t.integer  "github_fork_count",           default: 0,   null: false
    t.integer  "github_contributor_count",    default: 0,   null: false
    t.datetime "first_committed_at"
    t.datetime "last_committed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "score",                       default: 0,   null: false
    t.float    "recent_commit_age",           default: 1.0
  end

  add_index "pod_libraries", ["github_contributor_count"], name: "index_pod_libraries_on_github_contributor_count", using: :btree
  add_index "pod_libraries", ["github_stargazer_count"], name: "index_pod_libraries_on_github_stargazer_count", using: :btree
  add_index "pod_libraries", ["last_committed_at"], name: "index_pod_libraries_on_last_committed_at", using: :btree
  add_index "pod_libraries", ["score"], name: "index_pod_libraries_on_score", using: :btree

  create_table "raw_data", force: true do |t|
    t.integer  "pod_library_id"
    t.text     "github_raw_data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "raw_data", ["pod_library_id"], name: "index_raw_data_on_pod_library_id", using: :btree

end
