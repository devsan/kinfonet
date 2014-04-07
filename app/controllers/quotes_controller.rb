class QuotesController < ApplicationController
  before_action :find_quote, only: [:show]
  
  def index
    @search_type = params[:search_type]
    @quotes = Quote.text_search(params[:query], params[:search_type])
  end

  def show
  end

  private
    
    def find_quote
      begin
        @quote = Quote.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:alert] = "The quote you were looking for could not be found."
        redirect_to root_path
      end
    end


end
