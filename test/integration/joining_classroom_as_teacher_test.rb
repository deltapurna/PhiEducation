require 'test_helper'

class JoiningClassroomAsTeacherTest < ActionDispatch::IntegrationTest
  setup do
    stub_request(:any, /api.pusherapp.com*/).
      to_return(body: { key: 'value' }.to_json, status: 200)
  end

  test "joining an existing classroom" do
    get '/teachers/new'
    assert_response 200
    assert assigns(:teacher)

    post_via_redirect '/teachers', { room_code: rooms(:two).code }
    assert assigns(:room)
    teacher = Teacher.last
    assert_equal teacher.id, session[:teacher_id]
    assert_equal '1ABC', teacher.rooms.first.code
  end

  test "cannot join classroom that already have a teacher" do
    post_via_redirect '/teachers', { room_code: rooms(:one).code }
    assert_response 200
    assert_match /failed/, flash[:alert]
  end

  test "joining via direct url" do
    get_via_redirect "/t/#{rooms(:two).code}"
    assert assigns(:room)
    teacher = Teacher.last
    assert_equal teacher.id, session[:teacher_id]
    assert_equal '1ABC', teacher.rooms.first.code
  end
end
