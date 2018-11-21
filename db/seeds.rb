puts 'Destroying old data...'

User.destroy_all
PurchasedItem.destroy_all
Item.destroy_all
Order.destroy_all
Reservation.destroy_all

puts 'Creating new users...'

@consumers = []
@suppliers = []
@boths = []

2.times do
  consumer = User.new({
    name: Faker::FunnyName.two_word_name,
    email: Faker::Internet.unique.email,
    password: 'wasted',
    username: Faker::Internet.unique.username(8),
    role: 'consumer'
  })
  # consumer.remote_avatar_url = Cloudinary::Uploader.upload('https://picsum.photos/100/100/?random')['url']
  consumer.save!
  @consumers << consumer
end

2.times do
  supplier = User.new({
    name: Faker::FunnyName.name,
    email: Faker::Internet.unique.email,
    password: 'wasted',
    username: Faker::Internet.unique.username(8),
    role: 'supplier'
  })
  # supplier.remote_avatar_url = Cloudinary::Uploader.upload('https://picsum.photos/100/100/?random')['url']
  supplier.save!
  @suppliers << supplier
end

2.times do
  both = User.new({
    name: Faker::FunnyName.three_word_name,
    email: Faker::Internet.unique.email,
    password: 'wasted',
    username: Faker::Internet.unique.username(8),
    role: 'both'
  })
  # both.remote_avatar_url = Cloudinary::Uploader.upload('https://picsum.photos/100/100/?random')['url']
  both.save!
  @boths << both
end

puts "Finished creating 6 users (2 suppliers, 2 consumers, 2 both)"
puts "Creating new items..."
@items = []
5.times do
  item1 = Item.new({
    name: Faker::Food.dish,
    description: Faker::Food.description,
    expiration: Faker::Date.between(2.days.ago, Date.today),
    price: rand(1..5),
    pickup_time: Faker::Date.forward(5),
    quantity: rand(1..5),
    user: @suppliers.sample,
    category: Item::CATEGORY.sample,
    food_type: Item::TYPES.sample,
    address: Faker::Address.full_address,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude
  })
  # item1.remote_picture_url = Cloudinary::Uploader.upload('https://picsum.photos/200/300/?random')['url']
  item1.save!

  item2 = Item.new({
    name: Faker::Food.dish,
    description: Faker::Food.description,
    expiration: Faker::Date.between(2.days.ago, Date.today),
    price: rand(1..5),
    pickup_time: Faker::Date.forward(5),
    quantity: rand(1..5),
    user: @boths.sample,
    category: Item::CATEGORY.sample,
    food_type: Item::TYPES.sample,
    address: Faker::Address.full_address,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude
  })
  # item2.remote_picture_url = Cloudinary::Uploader.upload('https://picsum.photos/200/300/?random')['url']
  item2.save!

  @items << item1 << item2
  item = @items.sample

  @reservations = []
  rand(1..3).times do
    reservation1 = Reservation.create!({
      item: item,
      user: @consumers.sample,

    })
    reservation2 = Reservation.create!(
      item: item,
      user: @boths.sample,
      quantity: rand(1..3)
    )
    @reservations << reservation1 << reservation2

    @orders = []
    rand(1..2).times do
      order1 = Order.create!(
        total_price: rand(30..60),
        user: @consumers.sample
      )
      order2 = Order.create!(
        total_price: rand(30..60),
        user: @boths.sample
      )
      @orders << order1 << order2

      @purchased_items = []
      rand(1..2).times do
        rand(1..2).times do
          purchased_item = PurchasedItem.create!({
            item_purchase_price: rand(1..30),
            item_purchase_quantity: rand(1..3),
            item: item,
            item_purchase_name: item.name,
            item_purchase_description: item.description,
            item_purchase_expiration: item.expiration,
            item_purchase_pickup_time: item.pickup_time,
            order: @orders.sample
          })
          @purchased_items << purchased_item
        end

        @reservations.each do |reservation|
          reservation.purchased_item = @purchased_items.sample
          reservation.save!
        end
      end
    end
  end
  puts "Just created another item/reservation/order combination..."
end

puts 'Seed complete!'
