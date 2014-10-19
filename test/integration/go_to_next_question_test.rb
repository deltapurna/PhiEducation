require 'test_helper'

class GoToNextQuestionTest < ActionDispatch::IntegrationTest
  test "go to next question once the teacher trigger" do
    room = rooms(:two)
    teacher = join_as_teacher(room)
    teacher.post "rooms/#{room.id}/questions", { question: {
      content: 'The next question',
      question_type: 'TRUE_FALSE'
    }}

    teacher.assert_response 201
    assert_equal Mime::JSON, teacher.response.content_type
    assert_equal 'The next question', JSON.parse(
      teacher.response.body)['content']
  end

  test "should not go to next question if not the teacher" do
    room = rooms(:one)

    post "rooms/#{room.id}/questions", { question: {
      content: 'The next question',
      question_type: 'TRUE_FALSE'
    }}

    assert_match /not authorized/, flash[:error]
  end
end
