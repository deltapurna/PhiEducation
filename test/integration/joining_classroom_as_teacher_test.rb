require 'test_helper'

class JoiningClassroomAsTeacherTest < ActionDispatch::IntegrationTest
  test "joining an existing classroom" do
    get "/teachers/new"
    assert_response 200
    assert assigns(:teacher)

    post_via_redirect '/teachers', { room_code: rooms(:two).code }
    assert assigns(:room)
    assert_equal Teacher.last.id, session[:teacher_id]
    assert_equal '1ABC', Teacher.last.rooms.first.code
  end

  test "cannot join classroom that already have a teacher" do
    post_via_redirect '/teachers', { room_code: rooms(:one).code }
    assert_response 200
    assert_match /failed/, flash[:alert]
  end
end
