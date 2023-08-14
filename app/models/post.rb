class Post < ApplicationRecord
  
  belongs_to :user, optional: true
  has_many_attached :animalpics
  has_many :comments, dependent: :destroy
 
 
end
