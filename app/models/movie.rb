class Movie < ActiveRecord::Base

  validates :movie_id, uniqueness: true

end
