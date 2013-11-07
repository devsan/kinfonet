class ClassifiedsController < ApplicationController
  before_action :signed_in_user
  before_action :authenticate_user!, only: [:new, :create]
  
  def index
  end
  
  def show
  end

  def new
    @classified = Classified.new
  end

  def  create
    @classified = current_user.classifieds.build(classified_params)
    if @classified.save
      redirect_to @classified, notice: 'Your classified was successfully submitted. We will let you know once it has been approved for publication.'
    else
      render action: 'new'
    end
  end


  private
    def classified_params
      params.require(:classified).permit(:name, :content)
    end
end