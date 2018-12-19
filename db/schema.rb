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

ActiveRecord::Schema.define(version: 2018_12_16_194904) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "films", force: :cascade do |t|
    t.string "movie_url", limit: 250, null: false
    t.text "name", null: false
    t.integer "year", null: false
    t.integer "like", default: 0
    t.integer "dislike", default: 0
    t.text "director", null: false
    t.integer "episode", null: false
    t.index ["movie_url"], name: "index_films_on_movie_url"
  end

  create_table "users", force: :cascade do |t|
    t.text "nome", null: false
    t.string "email", limit: 100, null: false
    t.text "senha", null: false
    t.index ["email"], name: "index_users_on_email"
  end

  create_table "uservotos", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "film_id", null: false
    t.string "action", limit: 7, null: false
    t.index ["film_id"], name: "index_uservotos_on_film_id"
    t.index ["user_id"], name: "index_uservotos_on_user_id"
  end

end
