class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:edit]

  def index
  end

  def show
  end

  def edit
    @user.build_address unless @user.address.present?
    @states = @user.country_code ? find_states(@user.country_code) : []
  end

  def update
    @avatar_url_was = @user.avatar.url(:thumb)
    if @user.update(user_params)
      flash[:notice] = "Settings updated."
      # Sign in the user bypassing validation  
      sign_in @user, bypass: true if params[:user][:password].present?
      redirect_to @user
    else
      render 'edit'
    end
  end

  def get_states
    #@states = params[:country_code] ? find_states(params[:country_code]) : []
    find_states(params[:country_code])
    respond_to do |format|
      format.json { render json: @states.to_json }
    end
  end

  private

  def find_states(country_code)
      country = Carmen::Country.coded(country_code)
      @states = country.subregions.map {|state| [state.name, state.code]}.sort
  end
  
  def find_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The user you were looking for could not be found."
    redirect_to users_path
  end
  
  def user_params
    #raise params[:user].inspect
    #devise validation wont let us pass in an empty password
    if !params[:user][:password].present?
      params[:user].delete(:password)
    end
    params.require(:user).permit( 
            :email, 
            :password, :feedback,
            address_attributes: [ :city, :state_code, :country_code, :zip])
  end

end
