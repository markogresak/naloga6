class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :movie_id
      t.string :movie_title
      t.string :release_date
      t.string :video_release_date
      t.string :imdb_url
      t.string :poster

      t.timestamps null: false
    end
  end
end
