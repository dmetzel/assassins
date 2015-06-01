class CreateKills < ActiveRecord::Migration
  def change
    create_table :kills do |t|
      t.integer :victim_id
      t.datetime :kill_time
      t.text :kill_story
      t.integer :user_id
      t.integer :game_id

      t.timestamps

    end
  end
end
