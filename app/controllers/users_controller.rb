class UsersController < ApplicationController
  before_action :find_user, only: [:show]
  before_action :signed_in_user
  before_action :authenticate_user!, only: [:show]

  
  def index
  end

  def show

  end
  protected

  def find_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The user you were looking for could not be found."
    redirect_to users_path
  
  # Never trust parameters from the scary internet, only allow the white list through.
  def recipe_params
    params.require(:user).permit(:name)
  end end

end
