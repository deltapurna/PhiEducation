require 'test_helper'

class AnswerPolicyTest < ActiveSupport::TestCase
  test "can answer if associated to the room" do
    answer = Answer.new(content: 'my answer', question: questions(:one))
    policy = Pundit.policy(students(:one), answer)
    assert_equal true, policy.create?
  end

  test "cannot answer if don't have session" do
    answer = Answer.new(content: 'my answer', question: questions(:two))
    policy = Pundit.policy(students(:one), answer)
    assert_equal false, policy.create?
  end
end
