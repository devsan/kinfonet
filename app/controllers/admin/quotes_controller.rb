class Admin::QuotesController < Admin::BaseController
  before_action :set_quote, only: [:show, :edit, :update, :destroy]
  
  def index
    @search_type = params[:search_type]
    @query = params[:query].strip if params[:query]
    @quotes = Quote.text_search(@query, @search_type).paginate(page: params[:page], :per_page => 10)
  end
  
  def new
    @quote = Quote.new
  end

  def show
  end
  
  def create
    @quote = Quote.new(quote_params)
    if @quote.save
      redirect_to admin_quote_path(@quote), notice: "Quote was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @quote.update(quote_params)
      redirect_to admin_quote_path(@quote), notice: "Quote was successfully updated."
    else
      render :edit    
    end
  end

  def destroy
    @quote.destroy
    redirect_to admin_quotes_path
  end

  private    
  def set_quote
    @quote = Quote.find(params[:id])
  end
  
  def quote_params
    params.require(:quote)
          .permit(:phrase, :content, :source, 
                  :source_detail, :source_location,
                  :source_venue, :source_date, 
                  :publication_name, :publication_type
                  )
  end
end