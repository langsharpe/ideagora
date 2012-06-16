class LikesController < AuthenticatedController
  
  def create
    @like = Like.new(:user => current_user, :thought_id => params[:thought_id], :question_id => params[:question_id])
    create! do |success, failure|
      success.html { redirect_to_likeable }
      failure.html {
        # flash[:error] = resource.errors.on :thought_id  
        redirect_to_likeable
      }
    end
  end
  
  def destroy
    @like = Like.find_for(current_user.id, params)
    destroy! do |success, failure|
      success.html { redirect_to_likeable }
      failure.html {
        flash[:error] = "Hmm, something went wrong!"
        redirect_to_likeable
      }
    end
  end

  protected

  def redirect_to_likeable
    if @like.question.present?
      redirect_to questions_path
    elsif @like.thought.present?
      redirect_to thoughts_path
    end
  end
end
