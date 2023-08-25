class Post < ApplicationRecord

  belongs_to :user, optional: true
  has_many_attached :animalpics
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_tag_relations, dependent: :destroy
  has_many :post_tags, through: :post_tag_relations

  validates :title, presence: true
  validates :text, presence: true
  validates :animalpics, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["text"]
  end

 def favorited_by?(user)
   
   favorites.exists?(user_id: user.id)
 end

 def save_post_tags(tags)
   current_tags = self.post_tags.pluck(:name) unless self.post_tags.nil?
   old_tags = current_tags - tags
   new_tags = tags - current_tags

   old_tags.each do |old_name|
     self.post_tags.delete PostTag.find_by(name:old_name)
   end

   new_tags.each do |new_name|
     post_tag = PostTag.find_or_create_by(name:new_name)
     self.post_tags << post_tag
   end
 end

end
