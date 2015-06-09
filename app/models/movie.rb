class Movie < ActiveRecord::Base

  validates :movie_id, uniqueness: true
  has_many: ratings

end
