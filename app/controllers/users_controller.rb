class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:edit]

  def index
  end

  def show
  end

  def edit
    @user.build_address unless @user.address.present?
  end

  def update
    @avatar_url_was = @user.avatar.url(:thumb)
    if @user.update(user_params)
      flash[:notice] = "Profile updated."
      # Sign in the user bypassing validation  
      sign_in @user, bypass: true if params[:user][:password].present?
      redirect_to @user
    else
     #paperclip is producing duplicate error messages ....
      if @user.errors.include?(:avatar)
        @user.errors.messages.except!(:avatar_content_type,:avatar_file_name, :avatar_file_size)
      end
      render 'edit'
    end
  end

  private
  def find_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The user you were looking for could not be found."
    redirect_to users_path
  end
  
  def user_params  
    #devise validation wont let us pass in an empty password
    if !params[:user][:password].present?
      params[:user].delete(:password)
    end
    params.require(:user).permit( 
            :fname, :lname, :public_comment, :email, 
            :password, :feedback, :avatar, :delete_avatar, 
            address_attributes: [ :city, :state_code, :country_code, :zip])
  end

end
