class CreateWorkouts < ActiveRecord::Migration[6.0]
  def change
    create_table :workouts do |t|
      t.references :trainer, null: false, foreign_key: { to_table: :users }
      t.references :trainee, foreign_key: { to_table: :users }
      t.string :name, null: false
      t.string :state, null: false
      t.date :perform_date

      t.timestamps
    end

    add_index :workouts, [:trainer_id, :name], unique: true
  end
end
