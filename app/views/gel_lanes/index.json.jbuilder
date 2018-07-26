json.array!(@gel_lanes) do |gel_lane|
  json.extract! gel_lane, :id, :lane_number, :expected_product_size, :actual_product_size, :pass, :submitter_comments, :notes
  json.url gel_lane_url(gel_lane, format: :json)
end
