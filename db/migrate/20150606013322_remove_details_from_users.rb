class RemoveDetailsFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :status, :integer
  end
end
