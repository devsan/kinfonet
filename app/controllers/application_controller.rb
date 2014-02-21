class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  def authorize_admin!
    authenticate_user!
    unless current_user.admin?
      flash[:error] = "You must be an admin to do that."
      redirect_to root_path
    end
  end

end
