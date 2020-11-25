class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :type, null: false
      t.string :token, null: false, index: { unique: true }
      t.string :first_name, limit: 100, null: false
      t.string :last_name, limit: 100, null: false
      t.string :email, limit: 100, index: { unique: true }
      t.string :area_of_expertise

      t.timestamps
    end
  end
end
