class User < ActiveRecord::Base

  validates :label, uniqueness: true
  has_many :ratings
  has_many :movies, through: :ratings

  devise :database_authenticatable, :registerable

end
