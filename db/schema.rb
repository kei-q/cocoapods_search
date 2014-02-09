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

ActiveRecord::Schema.define(version: 20140209073805) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pod_libraries", force: true do |t|
    t.string   "name"
    t.string   "homepage"
    t.string   "social_media_url"
    t.string   "documentation_url"
    t.string   "summary"
    t.text     "description"
    t.string   "git_sourcce"
    t.string   "git_tag"
    t.string   "current_version"
    t.datetime "current_version_released_at"
    t.datetime "first_version_released_at"
    t.integer  "github_watcher_count"
    t.integer  "github_stargazer_count"
    t.integer  "github_fork_count"
    t.integer  "github_contributor_count"
    t.datetime "first_committed_at"
    t.datetime "last_committed_at"
    t.text     "recent_commits"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
