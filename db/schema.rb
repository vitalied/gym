# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_25_213742) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "trainees_trainers", id: false, force: :cascade do |t|
    t.bigint "trainee_id", null: false
    t.bigint "trainer_id", null: false
    t.index ["trainee_id"], name: "index_trainees_trainers_on_trainee_id"
    t.index ["trainer_id"], name: "index_trainees_trainers_on_trainer_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "type", null: false
    t.string "token", null: false
    t.string "first_name", limit: 100, null: false
    t.string "last_name", limit: 100, null: false
    t.string "email", limit: 100
    t.string "area_of_expertise"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["token"], name: "index_users_on_token", unique: true
  end

  add_foreign_key "trainees_trainers", "users", column: "trainee_id"
  add_foreign_key "trainees_trainers", "users", column: "trainer_id"
end
