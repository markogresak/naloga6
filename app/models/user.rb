class User < ActiveRecord::Base

  validates :label, uniqueness: true

end
