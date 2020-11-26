class CreateWorkoutResults < ActiveRecord::Migration[6.0]
  def change
    create_table :workout_results do |t|
      t.references :workout, null: false, foreign_key: true
      t.references :exercise, null: false, foreign_key: true
      t.integer :medium_pulse, null: false

      t.timestamps
    end

    add_index :workout_results, [:workout_id, :exercise_id], unique: true
  end
end
