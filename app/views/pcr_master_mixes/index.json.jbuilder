json.array!(@pcr_master_mixes) do |pcr_master_mix|
  json.extract! pcr_master_mix, :id, :name, :user_id, :vendor_id, :vendor_product_identifier, :vendor_product_url
  json.url pcr_master_mix_url(pcr_master_mix, format: :json)
end
