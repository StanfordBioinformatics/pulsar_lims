json.array!(@single_cell_sortings) do |single_cell_sorting|
  json.extract! single_cell_sorting, :id, :user_id, :name, :description
  json.url single_cell_sorting_url(single_cell_sorting, format: :json)
end
