json.array!(@pooled_libraries) do |pooled_library|
  json.extract! pooled_library, :id, :name, :user_id, :paired_end, :sequencing_library_prep_kit_id, :size_range
  json.url pooled_library_url(pooled_library, format: :json)
end
