class QuotesController < ApplicationController
  before_action :find_quote, only: [:show]
  
  def index
    @search_type = params[:search_type]
    @query = params[:query].strip
    @quotes = Quote.text_search(@query, @search_type).paginate(page: params[:page], :per_page => 10)
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
