class Admin::QuestionsController < Admin::BaseController
  respond_to :html, :json
  
  def index
    #logger.info Question.all.to_json
    respond_with(Question.all)
  end
  
  def new
    @question = Question.new
  end

  def show
    @question = Question.find(params[:id])
  end
  
  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:notice] = "Question created"
      redirect_to admin_question_path(@question)
    else
      render new
    end
  end

  private
    def question_params
      params.require(:question).permit(:name, :approved)
    end
end