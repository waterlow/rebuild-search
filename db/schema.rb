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

ActiveRecord::Schema.define() do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contributors", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_contributors_on_name", unique: true
  end

  create_table "episode_contributors", force: :cascade do |t|
    t.integer "episode_id", null: false
    t.integer "contributor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contributor_id"], name: "index_episode_contributors_on_contributor_id"
    t.index ["episode_id"], name: "index_episode_contributors_on_episode_id"
  end

  create_table "episodes", force: :cascade do |t|
    t.string "identifier", null: false
    t.string "title", null: false
    t.string "description", null: false
    t.integer "position", null: false
    t.datetime "published_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_episodes_on_identifier", unique: true
    t.index ["position"], name: "index_episodes_on_position", unique: true
  end

  create_table "show_notes", force: :cascade do |t|
    t.integer "episode_id", null: false
    t.string "text", null: false
    t.text "url", null: false
    t.integer "position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["episode_id"], name: "index_show_notes_on_episode_id"
    t.index ["id", "position"], name: "index_show_notes_on_id_and_position", unique: true
    t.index ["position"], name: "index_show_notes_on_position"
  end

  add_foreign_key "episode_contributors", "contributors"
  add_foreign_key "episode_contributors", "episodes"
  add_foreign_key "show_notes", "episodes"
end
