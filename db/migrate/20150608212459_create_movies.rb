class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.integer :unknown
      t.integer :action
      t.integer :adventure
      t.integer :animation
      t.integer :childrens
      t.integer :comedy
      t.integer :crime
      t.integer :documentary
      t.integer :drama
      t.integer :fantasy
      t.integer :film_noir
      t.integer :horror
      t.integer :musical
      t.integer :mystery
      t.integer :romance
      t.integer :sci_fi
      t.integer :thriller
      t.integer :war
      t.integer :western
      t.string :movie_id
      t.string :movie_title
      t.string :release_date
      t.string :video_release_date
      t.string :imdb_url

      t.timestamps null: false
    end
  end
end
