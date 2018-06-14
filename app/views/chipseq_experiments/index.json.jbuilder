json.array!(@chipseq_experiments) do |chipseq_experiment|
  json.extract! chipseq_experiment, :id, :user_id, :name, :description, :upstream_identifier, :target_id, :submitter_comments, :notes
  json.url chipseq_experiment_url(chipseq_experiment, format: :json)
end
