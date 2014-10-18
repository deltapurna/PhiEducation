require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  test "belongs to room" do
    student = students(:one)
    assert_equal 'ABC1', student.room.code
  end

  test "has many answers" do
    student = students(:one)
    assert_equal 'MyAnswer', student.answers.first.content
  end
end
