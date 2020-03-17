class Book < ApplicationRecord
   belongs_to :user, optional: true
   has_many :relations, class_name: "TagRelation", foreign_key: "book_id", dependent: :destroy
   has_many :books, through: :relations
   
   mount_uploader :image, BookImageUploader
   
end
