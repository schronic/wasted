puts 'Destroying old data...'

puts 'Creating new items...'

5.times do
  user = User.new({
    email: Faker::Internet.email,
    password: 'wasted',
    username: Faker::Internet.username(8),
    role: %w[consumer supplier both].sample
  })
    user.remote_avatar_url_url = Cloudinary::Uploader.upload('https://picsum.photos/100/100/?random')['url']
    user.save!

  rand(1..5).times do
    item = Item.new({
      name: Faker::Food.dish,
      description: Faker::Food.description,
      expiration: Faker::Date.between(2.days.ago, Date.today),
      price: rand(1..5),
      pickup_time: Faker::Date.forward(5),
      quantity: rand(1..5),
      user: user,
      category: Item.CATEGORY.sample,
      type: Item::TYPES.sample,
      address: Faker::Address.full_address
    })
    item.remote_picture_url = Cloudinary::Uploader.upload('https://picsum.photos/200/300/?random')['url']
    item.save!

    rand(1..5).times do
      purchase = Purchase.create!({
        total_price: rand(1..30)
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
  puts 'Just created another user with uploaded and purchased items...'
end

puts 'Seed complete!'
