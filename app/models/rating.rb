class Rating < ActiveRecord::Base

  validates :movie_id, uniqueness: { scope: :user_id }

end
