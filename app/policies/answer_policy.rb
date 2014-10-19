class AnswerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.try(:room) == record.question.room && 
      !record.question.have_answered?(user)
  end
end
