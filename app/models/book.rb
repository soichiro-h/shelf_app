class Book < ApplicationRecord
   belongs_to :user, optional: true
   has_many :related_tags, class_name: "TagRelation", foreign_key: "book_id", dependent: :destroy
   has_many :tags, through: :related_tags
   #has_many :related_videos, class_name: "VideoRelation", foreign_key: "book_id", dependent: :destroy
   has_many :videos, dependent: :destroy
   
   mount_uploader :image, BookImageUploader
   
   validates :title, presence: true 
   validates :price, numericality: :only_integer
   
   def self.search(search)
      return Book.all unless search
      Book.where("title LIKE ? OR memo LIKE ?","%#{search}%", "%#{search}%") 
    end
   
end
