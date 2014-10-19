require 'test_helper'

class QuestionPolicyTest < ActiveSupport::TestCase
  test "only the teacher can create the question in the room" do
    room = rooms(:one)
    question = Question.new(room: room)
    policy = Pundit.policy(room.teacher, question)
    assert_equal true, policy.create?
  end

  test "can't create question if not the teacher" do
    room = rooms(:one)
    question = Question.new(room: room)
    policy = Pundit.policy(teachers(:two), question)
    assert_equal false, policy.create?
  end
end
