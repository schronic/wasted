puts 'Destroying old data...'
puts 'Creating new items...'

20.times do
  item = Item.create!({
    name: Faker::Food.dish,
    description: Faker::Food.description,
    expiration: Faker::Date.between(2.days.ago, Date.today),
    price: rand(1..5),
    pickup_time: Faker::Date.forward(5),
    picture: 'https://picsum.photos/200/300/?random',
    quantity: rand(1..5)
  })
  rand(1..5).times do
    purchase = Purchase.create!({
      total_price: rand(1..30)
    })
    rand(1..5).times do
      user = User.create!({
        email: Faker::Internet.email,
        password: 'wasted',
        username: Faker::Internet.username(8),
        role: %w[consumer supplier].sample
      })
      rand(1..5).times do
        reservation = Reservation.create!({
          item: item,
          user: user,
          purchase: purchase
        })
      end
    end
  end
  puts 'Just created another purchased item...'
end

puts 'Seed complete!'
