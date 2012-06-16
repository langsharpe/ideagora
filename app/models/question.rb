class Question < ActiveRecord::Base
  belongs_to :user
  has_many :likes
  has_many :fans, :through => :likes, :source => :user
  
  def liked_by?(user)
    fans.exists? user
  end

  def to_s
    title
  end
end
