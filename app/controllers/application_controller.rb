class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :quote_of_the_day
  before_action :store_location

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

  def store_location
    unless (params[:controller] == "sessions" && !request.xhr?)
      url = request.fullpath
      session[:user_return_to] = url
    end
  end

  def stored_location_for(resource_or_scope)
    session[:user_return_to] || super
  end

  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end

  # def store_location
  #   # store last url - this is needed for post-login redirect to whatever the user last visited.
  #   if (request.fullpath != "/users/sign_in" &&
  #       request.fullpath != "/users/sign_up" &&
  #       request.fullpath != "/users/password" &&
  #       request.fullpath != "/users/sign_out" &&
  #       !request.xhr?) # don't store ajax calls
  #     session[:previous_url] = request.fullpath 
  #   end
  # end


end
