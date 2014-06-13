class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:edit]

  def index
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice] = "Profile updated."
      # Sign in the user bypassing validation  
      sign_in @user, bypass: true if params[:user][:password].present?
      redirect_to @user
    else
      #remove duplicate paperclip error keys
      @user.errors.messages.except!(:avatar_content_type,:avatar_file_name, :avatar_file_size)
      #
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
    
    params.require(:user).permit( :fname, :lname, :public_comment, :email, 
      :password, :feedback, :avatar, :delete_avatar)
  end

end
