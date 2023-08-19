class Post < ApplicationRecord
  
  belongs_to :user, optional: true
  has_many_attached :animalpics
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :title, presence: true
  validates :text, presence: true
  validates :animalpics, presence: true
 
 def favorited_by?(user)
   favorites.exists?(user_id: user.id)
 end 
 
end
