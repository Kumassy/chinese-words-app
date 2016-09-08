class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :pinnin
      t.string :kantaiji
      t.string :hinshi
      t.string :imi
      t.boolean :rigoushi
      t.string :page
      t.string :section

      t.timestamps null: false
    end
  end
end
