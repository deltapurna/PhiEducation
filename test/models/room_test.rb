require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  test "belongs to teacher" do
    room = rooms(:one)
    assert_equal teachers(:one).id, room.teacher.id
  end

  test "has many students" do
    room = rooms(:one)
    assert_equal students(:one).id, room.students.first.id
  end

  test "has many questions" do
    room = rooms(:one)
    assert_equal 'MyQuestion', room.questions.first.content
  end

  test "code has to be present" do
    room = Room.new(code: nil)
    assert_equal false, room.valid?
  end
end
