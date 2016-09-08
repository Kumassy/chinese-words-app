class RemoveEngagementFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :commitment
  end
end
