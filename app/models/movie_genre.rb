class MovieGenre < ActiveRecord::Base

  validates :movie_id, uniqueness: { scope: :genre_id }

end
