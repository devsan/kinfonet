class QuotesController < ApplicationController
  before_action :signed_in_user, except: [:index, :show]
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
  end

  def new
    @quote = Quote.new
  end

  def show
  end

  def create
    @quote = Quote.new(quote_params)
    if @quote.save
      #handle success
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private
    def quote_params
      params.require(:quote)
            .permit(:phrase, :content, :source, 
                    :source_detail, :source_location,
                    :source_venue, :source_date, 
                    :publication_name, :publication_type
                    )
    end
end
