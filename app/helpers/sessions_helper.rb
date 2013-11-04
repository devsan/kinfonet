module SessionsHelper

  def signed_in_user 
    store_location unless current_user.present?
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
end