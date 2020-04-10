class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  validates :nickname, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :tags
  has_many :books
  
  mount_uploader :avatar, AvatarUploader
  
end
