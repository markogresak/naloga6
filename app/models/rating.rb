class Rating < ActiveRecord::Base

  validates :movie_id, uniqueness: { scope: :user_id }

  belongs_to :user
  belongs_to :movie

end
