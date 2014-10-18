class Room < ActiveRecord::Base
  belongs_to :teacher
  has_many :students
  has_many :questions

  validates :code, presence: true
end
