class AddEngagementToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :commitment, :integer
  end
end
