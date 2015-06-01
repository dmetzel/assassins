class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :title
      t.text :description
      t.text :rules
      t.datetime :start_time
      t.integer :kill_window
      t.integer :gamemaster_id
      t.string :time_zone

      t.timestamps

    end
  end
end
