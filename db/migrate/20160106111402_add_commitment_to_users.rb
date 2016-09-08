class AddCommitmentToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :commitment, :integer,:default => 0
  end
end
