json.array!(@pcr) do |pcr|
  json.extract! pcr, :id, :user_id, :description, :pcr_master_mix_id, :forward_primer, :reverse_primer, :amplicon_size, :annealing_temperature, :extension_time, :num_cycles, :success
  json.url pcr(pcr, format: :json)
end
