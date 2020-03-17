class Tag < ApplicationRecord
  belongs_to :user
  has_many :relations, class_name: "TagRelation", foreign_key: "tag_id", dependent: :destroy
  has_many :books, through: :relations

end
