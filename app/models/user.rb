class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reservations, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :purchased_items, through: :orders

  ROLES = %w[consumer supplier both]

  mount_uploader :avatar, PhotoUploader
end
