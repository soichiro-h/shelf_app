class Tag < ApplicationRecord
  belongs_to :user, optional: true
  has_many :relations, class_name: "TagRelation", foreign_key: "tag_id", dependent: :destroy
  has_many :books, through: :relations
  
  validates :tag_title, presence: true, uniqueness: { scope: :deleted_at }, length: { maximum: 8 }

end
