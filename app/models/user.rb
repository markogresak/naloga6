class User < ActiveRecord::Base

  validates :email, uniqueness: true
  has_many :ratings
  has_many :movies, through: :ratings

  devise :database_authenticatable, :registerable

end
