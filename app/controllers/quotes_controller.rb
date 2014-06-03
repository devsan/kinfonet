class QuotesController < ApplicationController
  before_action :find_quote, only: [:show]
  
  def index 
    if params[:query].present?
      @query = params[:query].strip
      @search_type = params[:search_type]
      @quotes = Quote.text_search(@query, @search_type).paginate(page: params[:page], :per_page => 10)
    else
      @quotes = Quote.archived
      @quotes_by_month = @quotes.group_by { |q| q.display_date.beginning_of_month }.sort
    end
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
