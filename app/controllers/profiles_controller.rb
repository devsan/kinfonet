class ProfilesController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:edit, :update]
  #before_action :verify_user_owns_resource

  def show
  end

  def edit
  end

  def update
    @avatar_url_was = @user.avatar.url(:thumb)
    if @user.update(user_params)
      flash[:notice] = "Profile updated."
      redirect_to profile_path(@user)
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
  end

  def user_params  
    params.require(:user).permit( :fname, :lname, :public_comment,:avatar, :delete_avatar,)
  end

end