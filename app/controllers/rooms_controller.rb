class RoomsController < ApplicationController
  before_action :authorize, only: :destroy

  def new
    @room = Room.new
    @room.questions.build(
      content: "What is x if x + 13 = 42 ?\n\ta) 27\n\tb) 28\n\tc) 29\n\td) 30",
      question_type: "MULTIPLE_CHOICE")
  end

  def show
    @room = Room.find(params[:id])
  end

  def create
    @room = Room.new(room_params)
    @room.teacher = current_teacher if current_teacher

    if @room.save
      redirect_to room_path(@room)
    else
      render :new
    end
  end

  def destroy
    room = Room.find(params[:id])
    if room && room.teacher == current_teacher
      room.update!(closed_at: Time.now)
      Pusher["room_#{room.id}_channel"].trigger('change_room_status', {
        status: 'closed'
      })
      redirect_to root_path, notice: 'successfully closed the room'
    else
      redirect_to room_path(room), alert: 'failed to close the room'
    end
  end

  private

  def room_params
    params.require(:room).permit(
      :closed_at, questions_attributes: [:content, :question_type])
  end
end
