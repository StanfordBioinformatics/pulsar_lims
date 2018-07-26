json.array!(@agarose_gels) do |agarose_gel|
  json.extract! agarose_gel, :id, :percent_agarose, :voltage, :run_date, :notes, :user_id
  json.url agarose_gel_url(agarose_gel, format: :json)
end
