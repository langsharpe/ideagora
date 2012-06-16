class QuestionsController < AuthenticatedController
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(params[:question])
    @question.user = current_user
    create!
  end

  # def show
  #   @question = Question.find(params[:id])
  #   redirect_to questions_path, alert: "Question not found." unless @question.present?
  # end
end
