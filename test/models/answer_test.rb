require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  test "belongs to question" do
    answer = answers(:one)
    assert_equal 'MyQuestion', answer.question.content
  end

  test "belongs to student" do
    answer = answers(:one)
    assert_equal students(:one).id, answer.student.id
  end

  test "content has to be present" do
    answer = Answer.new(content: nil)
    assert_equal false, answer.valid?
  end
end
