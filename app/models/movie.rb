class Movie < ActiveRecord::Base

  validates :movie_id, uniqueness: true
  has_many :ratings
  has_many :users, through: :ratings
  has_many :movie_genres

end
