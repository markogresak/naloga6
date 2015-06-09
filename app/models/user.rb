class User < ActiveRecord::Base

  validates :label, uniqueness: true
  has_many :ratings

  devise :database_authenticatable, :registerable

end
