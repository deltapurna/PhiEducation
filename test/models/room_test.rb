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

  test "#generate_code generates unique 4 digits code for the room randomly" do
    room = Room.new
    room.generate_code
    assert_equal 4, room.code.size
    assert_equal false, Room.exists?(code: room.code)
  end

  test "call #generate_code before validation" do
    room = Room.create
    assert_not_nil room.code
  end
end
