json.array!(@crispr_genetic_modifications) do |crispr_genetic_modification|
  json.extract! crispr_genetic_modification, :id, :name, :user_id, :vendor_id, :vendor_product_identifier, :guide_rna_sequences, :insert_sequence
  json.url crispr_genetic_modification_url(crispr_genetic_modification, format: :json)
end
