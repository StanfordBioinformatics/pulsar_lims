json.array!(@immunoblots) do |immunoblot|
  json.extract! immunoblot, :id, :user_id, :date_performed, :submitter_comments, :notes
  json.url immunoblot_url(immunoblot, format: :json)
end
