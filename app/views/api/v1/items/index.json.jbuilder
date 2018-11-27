json.array! @items do |item|
  json.extract! item, :id, :description, :expiration, :price, :pickup_time,
                    :picture, :quantity, :user_id, :address, :category,
                    :price_cents, :distance_location
end

