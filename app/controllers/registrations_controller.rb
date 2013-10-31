class RegistrationsController < Devise::RegistrationsController
  before_filter :configure_permitted_parameters
  def create
    super
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :name
    end
end