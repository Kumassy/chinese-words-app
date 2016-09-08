class ChangeType < ActiveRecord::Migration
  def change
  	change_column :words, :page, :integer
  	change_column :words, :section, :integer

  end
end
