require 'test_helper'

class AnsweringAQuestionTest < ActionDispatch::IntegrationTest
  test "answering a question by the associated student" do
    room = rooms(:one)
    question = room.questions.last
    student = join_as_student(room) # prepare the session

    student.get "/questions/#{question.id}/answers/new"
    assert_equal 200, student.response.status
    assert student.assigns(:answer)

    student.post "/questions/#{question.id}/answers", { answer: {
      content: 'a'
    }}
    assert_equal 201, student.response.status
    assert_equal Mime::JSON, student.response.content_type
    assert_equal 'a', JSON.parse(student.response.body)['content']
  end

  test "can't answer a question if not a student" do
    room = rooms(:one)
    question = room.questions.last

    get "/questions/#{question.id}/answers/new"
    assert_match /not authorized/, flash[:error]

    post "/questions/#{question.id}/answers", { answer: {
      content: 'a'
    }}
    assert_match /not authorized/, flash[:error]
  end

  test "can't answer a question if not an associated student" do
    room_1 = rooms(:one)
    room_2 = rooms(:one)
    question = room_1.questions.last
    student = join_as_student(room_2) # prepare the session

    get "/questions/#{question.id}/answers/new"
    assert_match /not authorized/, flash[:error]

    post "/questions/#{question.id}/answers", { answer: {
      content: 'a'
    }}
    assert_match /not authorized/, flash[:error]
  end
end
