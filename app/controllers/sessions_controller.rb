class SessionsController < Devise::SessionsController

  protected 
    def after_sign_in_path_for(resource)
      session[:return_to] || resource
      session.delete(:return_to) if session[:return_to]
    end

    def after_sign_out_path_for(resource)
      root_path
    end
end