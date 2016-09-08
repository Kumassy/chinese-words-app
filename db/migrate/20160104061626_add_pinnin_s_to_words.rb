class AddPinninSToWords < ActiveRecord::Migration
  def change
  	add_column :words, :styledpinnin, :string
  end
end
