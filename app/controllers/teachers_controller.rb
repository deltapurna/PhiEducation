class TeachersController < ApplicationController
  def new
    @teacher = Teacher.new
  end

  def create
    room = Room.find_by(code: params[:room_code]) if params[:room_code]
    if room && !room.teacher
      room.update!(teacher: Teacher.create!)
      session[:teacher_id] = room.teacher.id
      redirect_to room_path(room)
    else
      flash.now.alert = 'failed to go to classroom there is an ongoing class'
      render :new
    end
  end
end
