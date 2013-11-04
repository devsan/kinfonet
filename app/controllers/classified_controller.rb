class ClassifiedsController < ApplicationController
  before_action :signed_in_user
  before_action :authenticate_user!, only: [:new]
  
  def index
  end
  def new
  end
end