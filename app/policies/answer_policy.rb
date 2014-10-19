class AnswerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.try(:room) == record.question.room && !record.class.exists?(student: user)
  end
end
