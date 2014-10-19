class StudentsController < ApplicationController
  def new
    @student = Student.new
  end

  def create
    room = Room.find_by(code: params[:room_code]) if params[:room_code]
    
    if room
      room.students << Student.create!
      room.save!
      session[:student_id] = room.students.last.id
      Pusher["room_#{room.id}_channel"].trigger('new_student', {
        student_id: session[:student_id],
        size: room.students.size
      })
      redirect_to room_path(room)
    else
      flash.now.alert = 'the room code is invalid'
      render :new
    end
  end
end
