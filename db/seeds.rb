LATITUDE = [-34.6056872, -34.6056874, -34.6056876, -34.6056878, -34.6056880]
LONGITUDE = [-58.4023744, -58.4023744, -58.4023744, -58.4023744, -58.4023744]
ADDRESS = ["Niceto Vega 4788, Palermo, Buenos Aires", "Santa Fe 3387 4788, Palermo, Buenos Aires", "F. Alcorta 3004, Palermo, Buenos Aires", "Av. Libertador 3488, Palermo, Buenos Aires", "Castex 4300, Palermo, Buenos Aires", "Callao 4030, Recoleta, Buenos Aires"]
FOOD_ME = [
  {
    name: "Shrimps with curry",
    url: "https://res.cloudinary.com/astridbosch/image/upload/v1543415655/wasted/camarones.jpg",
    category: "Asian"
  },
  {
    name: "Orange Duck",
    url: "https://res.cloudinary.com/astridbosch/image/upload/v1543415729/wasted/orange_duck.jpg",
    category: "Asian"
  },
  {
    name: "Dumplings",
    url: "https://res.cloudinary.com/astridbosch/image/upload/v1543415771/wasted/dumpling.jpg",
    category: "Asian"
  },
  {
    name: "Beef Nachos",
    url: "https://res.cloudinary.com/astridbosch/image/upload/v1543418991/wasted/mexican3.jpg",
    category: "Mexican"
  },
  {
    name: "Tacos",
    url: "https://res.cloudinary.com/astridbosch/image/upload/v1543418977/wasted/mexican1.jpg",
    category: "Mexican"
  },
  {
    name: "Vegeterian Tacos",
    url: "https://res.cloudinary.com/astridbosch/image/upload/v1543418977/wasted/mexican2.jpg",
    category: "Asian"
  },
  {
    name: "Pork Ramen Noodle Soup",
    url: "https://res.cloudinary.com/astridbosch/image/upload/v1543418958/wasted/japanese3.jpg",
    category: "Japanese"
  },
  {
    name: "Tabbouleh",
    url: "https://res.cloudinary.com/astridbosch/image/upload/v1543415918/wasted/greek1.jpg",
    category: "mediterranean"
  },
  {
    name: "Couscous",
    url: "https://res.cloudinary.com/astridbosch/image/upload/v1543418952/wasted/mediterranea2.jpg",
    category: "mediterranean"
  },
  {
    name: "Fish delicatessen",
    url: "https://res.cloudinary.com/astridbosch/image/upload/v1543418948/wasted/japanese2.jpg",
    category: "Japanese"
  },
  {
    name: "Chicken Kabobs",
    url: "https://res.cloudinary.com/astridbosch/image/upload/v1543418947/wasted/mediterranea1.jpg",
    category: "mediterranean"
  },
  {
    name: "Tuna",
    url: "https://res.cloudinary.com/astridbosch/image/upload/v1543418934/wasted/japanese1.jpg",
    category: "Japanese"
  }
]

puts 'Destroying old data...'

Reservation.destroy_all
PurchasedItem.destroy_all
User.destroy_all
Item.destroy_all
Order.destroy_all
Type.destroy_all
Feature.destroy_all

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
  # consumer.remote_avatar = Cloudinary::Uploader.upload('https://picsum.photos/100/100/?random')['url']
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
  # supplier.remote_avatar = Cloudinary::Uploader.upload('https://picsum.photos/100/100/?random')['url']
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
  # both.remote_avatar = Cloudinary::Uploader.upload('https://picsum.photos/100/100/?random')['url']
  both.save!
  @boths << both
end

puts "Finished creating 6 users (2 suppliers, 2 consumers, 2 both)"
puts "Creating new items..."
@items = []

FOOD_ME.each do |food|
  item = Item.new({
    name: food[:name],
    description: Faker::Food.description,
    expiration: Faker::Time.backward(30, :morning),
    price: rand(30..120),
    pickup_time: Time.now + rand(5..10).days,
    quantity: rand(1..5),
    user: @suppliers.sample,
    category: food[:category],
    address: ADDRESS.sample,
    latitude: LATITUDE.sample,
    longitude: LONGITUDE.sample
  })
  item.save!
  item.remote_picture_url = food[:url]
  item.save!
  @items << item
end

2.times do

  item = @items.sample

  @reservations = []
  rand(2..4).times do
    reservation1 = Reservation.create({
      item: item,
      user: @consumers.sample,
      quantity: rand(1..3)
    })
    reservation2 = Reservation.create(
      item: item,
      user: @boths.sample,
      quantity: rand(1..3)
      )
    @reservations << reservation1 << reservation2

    @orders = []
    @state = ['paid', 'paid', 'paid', 'paid', 'pending']
    rand(1..2).times do
      @order1 = Order.new(
        amount: rand(30..60),
        user: @consumers.sample,
        state: @state.sample
        )
      @order2 = Order.new(
        amount: rand(30..60),
        user: @boths.sample,
        state: @state.sample
        )
      @orders << @order1 << @order2

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
          reservation.save
        end
        @order1.save
        @order2.save
      end
    end
  end
  puts "Just created another item/reservation/order combination..."
end

Order.left_joins(:purchased_items)
.where(purchased_items: { order_id: nil })
.destroy_all

Type::TYPES.each do |type|
  Type.create(
    name: type)
end

@items.each do |item|
  2.times do
    Feature.create(
      item: item,
      type: Type.all.sample
      )
  end
end

puts 'Seed complete!'


