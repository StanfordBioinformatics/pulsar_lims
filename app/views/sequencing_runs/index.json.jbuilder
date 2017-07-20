json.array!(@sequencing_run) do |sequencing_run|
  json.extract! sequencing_run, :id, :user_id, :sequencing_request_id, :run_name, :lane, :comment
  json.url sequencing_run(sequencing_run, format: :json)
end
