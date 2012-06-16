class AddQuestionIdToLike < ActiveRecord::Migration
  def change
    add_column :likes, :question_id, :integer
  end
end
