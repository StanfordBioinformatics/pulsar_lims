json.array!(@chromosomes) do |chromosome|
  json.extract! chromosome, :id, :name, :user_id, :reference_genome_id
  json.url chromosome_url(chromosome, format: :json)
end
