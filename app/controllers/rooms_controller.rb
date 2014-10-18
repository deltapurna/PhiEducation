class RoomsController < ApplicationController
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

    if @room.save
      redirect_to room_path(@room)
    else
      render :new
    end
  end

  private

  def room_params
    params.require(:room).permit(
      questions_attributes: [:content, :question_type])
  end
end
