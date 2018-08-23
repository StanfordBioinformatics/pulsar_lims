json.array!(@shippings) do |shipping|
  json.extract! shipping, :id, :user_id, :carrier, :tracking_code, :date_shipped, :received
  json.url shipping_url(shipping, format: :json)
end
