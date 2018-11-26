puts 'Destroying old data...'

User.destroy_all
PurchasedItem.destroy_all
Item.destroy_all
Order.destroy_all
Reservation.destroy_all
Type.destroy_all
Feature.destroy_all

puts 'Creating new users...'

Type::TYPES.each do |type|
  Type.create(name: type)
end


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



puts "Finished creating 6 users (2 suppliers, 2 consumers, 2 both)"
puts "Creating new items..."
@items = []
3.times do
  item1 = Item.new({
    name: Faker::Food.dish,
    description: Faker::Food.description,
    expiration: Faker::Date.between(2.days.ago, Date.today),
    price: rand(3..5),
    pickup_time: Faker::Date.between(1.day.from_now, 3.days.from_now),
    quantity: rand(1..5),
    user: @suppliers.sample,
    category: Item::CATEGORY.sample,
    address: Faker::Address.full_address,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude
  })
  #item1.remote_picture_url = Cloudinary::Uploader.upload('https://picsum.photos/200/300/?random')['url']
  item1.save!

  item2 = Item.new({
    name: Faker::Food.dish,
    description: Faker::Food.description,
    expiration: Faker::Date.between(2.days.ago, Date.today),
    price: rand(3..5),
    pickup_time: Faker::Date.between(1.day.from_now, 3.days.from_now),
    quantity: rand(1..5),
    user: @suppliers.sample,
    category: Item::CATEGORY.sample,
    address: Faker::Address.full_address,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude
  })
  #item2.remote_picture_url = Cloudinary::Uploader.upload('https://picsum.photos/200/300/?random')['url']
  item2.save!

  @items << item1 << item2
  item = @items.sample
end

@items.each do |item|
  3.times do
  Feature.create(
    item: item,
    type: Type.all.sample
    )
end
end

puts "Just created another item/reservation/order combination..."



puts 'Seed complete!'


