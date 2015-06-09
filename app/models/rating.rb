class Rating < ActiveRecord::Base

  validates :movie_id, uniqueness: { scope: :user_id }, on: :create

  belongs_to :user
  belongs_to :movie

  def self.update_or_create(attributes)
    obj = first || new
    obj.assign_attributes(attributes)
    obj
  end

end
