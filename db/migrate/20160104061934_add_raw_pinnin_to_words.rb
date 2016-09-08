class AddRawPinninToWords < ActiveRecord::Migration
  def change
  	add_column :words, :rawpinnin, :string
  end
end
