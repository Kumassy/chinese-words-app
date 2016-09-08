class CreateUsersWords < ActiveRecord::Migration
  def change
    create_table :users_words, id: false do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :word, index: true, foreign_key: true, null: false
    end
  end
end
