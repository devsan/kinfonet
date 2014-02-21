class Admin::QuotesController < Admin::BaseController
  def new
    @quote = Quote.new
  end
  
  def create
    @quote = Quote.new(quote_params)
    if @quote.save
      redirect_to @quote
    else
      render :new
    end
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