json.array!(@atacseqs) do |atacseq|
  json.extract! atacseq, :id, :user_id, :name, :description, :submitter_comments, :notes
  json.url atacseq_url(atacseq, format: :json)
end
