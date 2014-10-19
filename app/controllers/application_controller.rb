class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  helper_method :current_teacher
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_teacher
    @current_teacher ||= Teacher.
      find(session[:teacher_id]) if session[:teacher_id]
  end

  private

  def user_not_authorized
    flash[:error] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
