class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :movie_id
      t.integer :rating

      t.timestamps null: false
    end
    add_index :ratings, :user_id
    add_index :ratings, :movie_id
  end
end
