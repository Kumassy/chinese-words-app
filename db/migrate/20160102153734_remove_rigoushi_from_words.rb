class RemoveRigoushiFromWords < ActiveRecord::Migration
  def change
  	remove_column :words, :rigoushi
  end
end
