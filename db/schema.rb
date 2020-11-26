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

ActiveRecord::Schema.define(version: 2020_11_25_225741) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercises", force: :cascade do |t|
    t.string "name", null: false
    t.integer "duration", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_exercises_on_name", unique: true
  end

  create_table "exercises_workouts", id: false, force: :cascade do |t|
    t.bigint "exercise_id", null: false
    t.bigint "workout_id", null: false
    t.index ["exercise_id"], name: "index_exercises_workouts_on_exercise_id"
    t.index ["workout_id"], name: "index_exercises_workouts_on_workout_id"
  end

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

  create_table "workouts", force: :cascade do |t|
    t.bigint "trainer_id", null: false
    t.bigint "trainee_id"
    t.string "name", null: false
    t.string "state", null: false
    t.date "perform_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["trainee_id"], name: "index_workouts_on_trainee_id"
    t.index ["trainer_id", "name"], name: "index_workouts_on_trainer_id_and_name", unique: true
    t.index ["trainer_id"], name: "index_workouts_on_trainer_id"
  end

  add_foreign_key "exercises_workouts", "exercises"
  add_foreign_key "exercises_workouts", "workouts"
  add_foreign_key "trainees_trainers", "users", column: "trainee_id"
  add_foreign_key "trainees_trainers", "users", column: "trainer_id"
  add_foreign_key "workouts", "users", column: "trainee_id"
  add_foreign_key "workouts", "users", column: "trainer_id"
end
