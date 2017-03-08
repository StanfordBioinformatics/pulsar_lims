json.array!(@sequencing_library_prep_kits) do |sequencing_library_prep_kit|
  json.extract! sequencing_library_prep_kit, :id, :user_id, :name, :vendor_id, :description
  json.url sequencing_library_prep_kit_url(sequencing_library_prep_kit, format: :json)
end
