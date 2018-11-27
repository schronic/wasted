json.extract! @item, :id, :description, :expiration, :price, :pickup_time,
                    :picture, :quantity, :user_id, :address, :category,
                    :price_cents, :distance_location
json.comments @item.description do |comment|
  json.extract! comment, :id, :comment
end
