class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters
  def create
    super
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << [ :fname, :lname ]
      devise_parameter_sanitizer.for(:account_update) do |u|
        u.permit(:fname, :lname,
          :email, :password, :password_confirmation :current_password)
      end
    end

    def after_sign_up_path_for(resource)
      user_path(resource)
    end

    def after_update_path_for(resource)
      case resource
      when :user, User
        user_path(resource)
      else
        super
      end
    end
end
