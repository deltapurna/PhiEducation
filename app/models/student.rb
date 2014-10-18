class Student < ActiveRecord::Base
  belongs_to :room
  has_many :answers
end
