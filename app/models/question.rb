class Question < ActiveRecord::Base
  QUESTION_TYPE = %w(MULTIPLE_CHOICE, TRUE_FALSE, TEXT)

  belongs_to :room
  has_many :answers

  validates :content, :question_type, presence: true
  validates :question_type, inclusion: { in: QUESTION_TYPE }
end
