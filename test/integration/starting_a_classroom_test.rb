require 'test_helper'

class StartingAClassroomTest < ActionDispatch::IntegrationTest
  test "starting a room redirect to the room and display the room code" do
    get '/'
    assert_response 200
    assert assigns(:room)

    post_via_redirect '/rooms', {
      room: {
        questions_attributes: [
          {
            content: 'Question in New Room',
            question_type: 'MULTIPLE_CHOICE'
          }
        ]
      }
    }
    assert assigns(:room)
    assert_equal 'Question in New Room', Room.last.questions.first.content
    assert_equal false, Room.last.active?
  end

  test "starting a room by existing teacher immediately activate the room" do
    room = rooms(:two)
    teacher = join_as_teacher(room)
    teacher.post_via_redirect '/rooms', {
      room: {
        questions_attributes: [
          {
            content: 'Question in New Room',
            question_type: 'MULTIPLE_CHOICE'
          }
        ]
      }
    }
    assert teacher.assigns(:room)
    assert_equal 'Question in New Room', Room.last.questions.first.content
    assert_equal true, Room.last.active?
  end

  private

  def join_as_teacher(room)
    open_session do |sess|
      sess.post_via_redirect '/teachers', { room_code: room.code }
    end
  end
end
