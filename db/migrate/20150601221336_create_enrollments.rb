class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :killed_by
      t.boolean :dead
      t.boolean :autokilled
      t.boolean :confirmed
      t.integer :game_id
      t.integer :user_order
      t.datetime :kill_time
      t.string :alias
      t.integer :user_id

      t.timestamps

    end
  end
end
