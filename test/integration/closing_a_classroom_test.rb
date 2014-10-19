require 'test_helper'

class ClosingAClassroomTest < ActionDispatch::IntegrationTest
  test "closing a classroom by the associated teacher" do
    room = rooms(:two)
    teacher = join_as_teacher(room)
    teacher.delete_via_redirect "/rooms/#{room.id}"

    assert_equal false, Room.find(room.id).active?
    assert_match /success/, teacher.flash[:notice]
  end

  test "not closing a classroom if not by the associated teacher" do
    room_1 = rooms(:one)
    room_2 = rooms(:two)
    teacher = join_as_teacher(room_2)
    # teacher of room 2 trying to delete room 1
    teacher.delete_via_redirect "/rooms/#{room_1.id}"

    assert_equal true, Room.find(room_1.id).active?
    assert_match /not authorized/, teacher.flash[:error]
  end
end
