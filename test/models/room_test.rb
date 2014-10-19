require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  test "belongs to teacher" do
    room = rooms(:one)
    assert_equal teachers(:one).id, room.teacher.id
  end

  test "has many students" do
    room = rooms(:one)
    assert_equal students(:one).id, room.students.last.id
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

  test "call #generate_code before validation on create" do
    room = Room.create
    original_code = room.code
    assert_not_nil room.code
    room.update!(teacher: teachers(:two))
    assert_equal original_code, room.code 
  end

  test "room #active? if has teacher and the room is not closed" do
    room = Room.create(closed_at: nil)
    assert_equal false, room.active?

    room.update!(teacher: teachers(:two))
    assert_equal true, room.active?

    room.update!(closed_at: Time.now)
    assert_equal false, room.active?
  end
end
