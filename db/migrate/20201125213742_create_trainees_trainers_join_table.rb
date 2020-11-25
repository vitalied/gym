class CreateTraineesTrainersJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_table :trainees_trainers, id: false do |t|
      t.references :trainee, null: false, foreign_key: { to_table: :users }
      t.references :trainer, null: false, foreign_key: { to_table: :users }
    end
  end
end
