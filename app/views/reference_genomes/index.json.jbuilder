json.array!(@reference_genomes) do |reference_genome|
  json.extract! reference_genome, :id, :name, :url
  json.url reference_genome_url(reference_genome, format: :json)
end
