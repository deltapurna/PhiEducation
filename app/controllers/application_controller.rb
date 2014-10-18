class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_teacher

  def current_teacher
    @current_teacher ||= Teacher.
      find(session[:teacher_id]) if session[:teacher_id]
  end

  def authorize
    redirect_to root_path, alert: "Unauthorized Access" unless current_teacher
  end
end
