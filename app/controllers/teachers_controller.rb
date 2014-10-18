class TeachersController < ApplicationController
  def index
    Pusher["room_#{1}_channel"].trigger('change_room_status', {
      status: 'active'
    })
    render text: 'pushed!'
  end

  def new
    @teacher = Teacher.new
  end

  def create
    room = Room.find_by(code: params[:room_code]) if params[:room_code]
    if room && !room.teacher
      room.update!(teacher: Teacher.create!)
      session[:teacher_id] = room.teacher.id
      Pusher["room_#{room.id}_channel"].trigger('change_room_status', {
        status: 'active'
      })
      redirect_to room_path(room)
    else
      flash.now.alert = 'failed to go to classroom there is an ongoing class'
      render :new
    end
  end
end
