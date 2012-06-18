class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :thought, :counter_cache => true
  belongs_to :question, :counter_cache => true
  
  validates :question_id, :uniqueness => { :scope => :user_id, :message => "You couldn't possibly like this more than you already do!", :if => :question_id? }
  validates :thought_id, :uniqueness => { :scope => :user_id, :message => "You couldn't possibly like this more than you already do!", :if => :thought_id? }
  
  scope :for_user, lambda { |user| self.where(:user_id => user.id) }

  def self.find_for(user_id, params)
    if params[:thought_id]
      find_by_user_id_and_thought_id(user_id, params[:thought_id])
    elsif params[:question_id]
      find_by_user_id_and_question_id(user_id, params[:question_id])
    end
  end
end
