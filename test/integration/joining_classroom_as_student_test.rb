require 'test_helper'

class JoiningClassroomAsStudentTest < ActionDispatch::IntegrationTest
  test "joining an existing classroom" do
    get '/students/new'
    assert_response 200
    assert assigns(:student)

    post_via_redirect '/students', { room_code: rooms(:one).code }
    assert assigns(:room)
    student = Student.last
    assert_equal student.id, session[:student_id]
    assert_equal 'ABC1', student.room.code
  end

  test "not joining an invalid classroom" do
    get '/students/new'
    assert_response 200
    assert assigns(:student)

    post_via_redirect '/students', { room_code: 'wrongcode' }
    assert_match /invalid/, flash[:alert]
  end
end
