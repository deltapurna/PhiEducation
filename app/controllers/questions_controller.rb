class QuestionsController < ApplicationController
  before_action :authorize

  def create
    room = Room.find(params[:room_id])
    question = room.questions.build(question_params)

    if question.save
      Pusher["room_#{room.id}_channel"].trigger('change_question', {
        content: question.content,
        number: room.questions.size
      })
      render json: question, status: 201
    else
      render json: question.errors, status: 422
    end
  end

  private
  
  def question_params
    params.require(:question).permit(:content, :question_type)
  end
end
