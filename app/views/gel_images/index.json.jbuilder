json.array!(@gel_images) do |gel_image|
  json.extract! gel_image, :id, :user_id, :gel_id, :film_exposure_time, :image
  json.url gel_image_url(gel_image, format: :json)
end
