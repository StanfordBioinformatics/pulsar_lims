json.array!(@human_genes) do |human_gene|
  json.extract! human_gene, :id, :encode_identifier, :name
  json.url human_gene_url(human_gene, format: :json)
end
