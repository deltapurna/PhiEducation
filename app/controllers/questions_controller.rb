class QuestionsController < ApplicationController
  after_action :verify_authorized

  def create
    room = Room.find(params[:room_id])
    question = room.questions.build(question_params)
    authorize question

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

  def pundit_user
    current_teacher
  end

  private
  
  def question_params
    params.require(:question).permit(:content, :question_type)
  end
end
