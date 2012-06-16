class AddLikesCountToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :likes_count, :integer
  end
end
