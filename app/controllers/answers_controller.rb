class AnswersController < ApplicationController
  after_action :verify_authorized

  def new
    @question = Question.find(params[:question_id])
    @answer = @question.answers.build
    authorize @answer

    case @question.question_type
    when 'MULTIPLE_CHOICE'
      render partial: 'multiple_choice' and return
    when 'TRUE_FALSE'
      render partial: 'true_false' and return
    when 'TEXT'
      render partial: 'text' and return
    end
  end

  def create
    question = Question.find(params[:question_id])
    answer = question.answers.build(answer_params)
    authorize answer

    if answer.save
      Pusher["room_#{question.room.id}_channel"].trigger('new_answer', {
        answer: answer.content,
        size: question.answers.size
      })
      render json: answer, status: 201
    else
      render json: answer.errors, status: 422
    end
  end

  def pundit_user
    current_student
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end
end
