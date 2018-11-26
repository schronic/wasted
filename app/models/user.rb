class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    acts_as_token_authenticatable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create :send_welcome_email
  after_create :subscribe_to_newsletter

  has_many :reservations, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :purchased_items, through: :orders

ROLES = %w[consumer supplier both]

  mount_uploader :avatar, PhotoUploader

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end

  def subscribe_to_newsletter
    begin
      SubscribeToNewsletterService.new(self).call if self.subscribed
    rescue Gibbon::MailChimpError => e
      # Do nothing
    end
  end

  def items_rescued
    self.orders.map { |order| order.purchased_items.count }.sum
  end

  def money_saved
    self.orders.map do |order|
      order.purchased_items.map { |item| item.item_purchase_price }.sum
    end.sum
  end

  def food_rescued
   0.25*(self.orders.map { |order| order.purchased_items.count }.sum)
  end
end

