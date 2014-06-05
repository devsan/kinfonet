class UsersController < ApplicationController
  before_action :find_user, only: [:show]
  before_action :authenticate_user!, only: [:edit]

  def index
  end

  def show
  end

  def edit
  end

  #https://github.com/orthodoc/ayosi/blob/master/app/controllers/users_controller.rb
  # def create
  #   raise params.inspect
  #   logger.info "#{user_params}"
  #   @quote = Quote.new(user_params)
  # end

  
  private
  def find_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The user you were looking for could not be found."
    redirect_to users_path
  end
  
  # Never trust parameters from the scary internet, only allow the white list through.
  # def user_params
  #   params.require(:user).permit(:fname)
  # end

end
