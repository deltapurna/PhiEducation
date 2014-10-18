class Room < ActiveRecord::Base
  belongs_to :teacher
  has_many :students
  has_many :questions

  accepts_nested_attributes_for :questions, allow_destroy: true

  validates :code, presence: true, uniqueness: true

  before_validation :generate_code

  def generate_code
    self.code = loop do
      code = ('a'..'z').to_a.concat((0..9).to_a).shuffle[0..3].join
      break code unless self.class.exists?(code: code)
    end
  end
end
