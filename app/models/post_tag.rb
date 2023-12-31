class PostTag < ApplicationRecord
  has_many :post_tag_relations, dependent: :destroy
  has_many :posts, through: :post_tag_relations
  
  validates :name, presence:true, length:{maximum:50}
  
end
