class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :student

  validates :content, presence: true
end
