require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test "belongs to room" do
    question = questions(:one)
    assert_equal 'ABC1', question.room.code
  end

  test "has many answers" do
    question = questions(:one)
    assert_equal 'MyAnswer', question.answers.first.content
  end

  test "content has to be present" do
    question = Question.new(content: nil, question_type: 'MULTIPLE_CHOICE')
    assert_equal false, question.valid?
  end

  test "question type has to be present" do
    question = Question.new(content: 'My Question', question_type: nil)
    assert_equal false, question.valid?
  end

  test "question type has to be one of: MULTIPLE_CHOICE, TRUE_FALSE or TEXT" do
    question = Question.new(content: 'My Question', question_type: 'wrongtype')
    assert_equal false, question.valid?
    question = Question.new(content: 'My Question', question_type: 'TEXT')
    assert_equal true, question.valid?
  end
end
