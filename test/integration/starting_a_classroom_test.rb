require 'test_helper'

class StartingAClassroomTest < ActionDispatch::IntegrationTest
  test "starting a room should redirect to the room and display the room code" do
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
  end
end
