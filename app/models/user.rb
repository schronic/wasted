class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
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
    #UserMailer.welcome(self).deliver_now
  end

  def subscribe_to_newsletter
    begin
      #SubscribeToNewsletterService.new(self).call if subscribed
    rescue Gibbon::MailChimpError => e
      # Do nothing
    end
  end

  def items_rescued_by_consumer
    orders.where(state: 'paid')
          .map do |order|
            order.purchased_items
                 .map(&:item_purchase_quantity)
                 .sum
          end.sum
  end

  def food_rescued_by_consumer
    items_rescued_by_consumer * 0.25
  end

  def items_rescued_by_supplier
    items.map do |item|
      item.purchased_items
          .joins(:order)
          .where(orders: { state: 'paid' })
          .map(&:item_purchase_quantity)
          .sum
    end.sum
  end

  def food_rescued_by_supplier
    items_rescued_by_supplier * 0.25
  end

  def money_saved
    orders.where(state: 'paid')
          .map do |order|
            order.purchased_items
                 .map(&:item_purchase_price)
                 .zip(order.purchased_items
                           .map(&:item_purchase_quantity))
                 .map { |price, quantity| price * quantity }
                 .inject(:+)
          end.inject(:+)

          # Same as Lines 59-62
          #.map { |purchased_item| purchased_item.item_purchase_price_cents * purchased_item.item_purchase_quantity }
  end

  def money_earned
    PurchasedItem.joins(:item, :order)
                 .where(items: { user_id: id })
                 .where(orders: { state: 'paid' })
                 .map(&:item_purchase_price)
                 .inject(:+)
  end
end
