class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :quote_of_the_day

  private

  def authorize_admin!
    authenticate_user!
    unless current_user.admin?
      flash[:error] = "You must be an admin to do that."
      redirect_to root_path
    end
  end

  def quote_of_the_day
    @quote_of_the_day = Quote.for_today
  end

end
