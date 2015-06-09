class CreateMovieGenres < ActiveRecord::Migration
  def change
    create_table :movie_genres do |t|
      t.integer :movie_id
      t.integer :genre_id

      t.timestamps null: false
    end
    add_index :movie_genres, :genre_id
    add_index :movie_genres, :movie_id
  end
end
