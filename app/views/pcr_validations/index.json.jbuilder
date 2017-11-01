json.array!(@pcr_validations) do |pcr_validation|
  json.extract! pcr_validation, :id, :user_id, :description, :pcr_master_mix_id, :forward_primer, :reverse_primer, :amplicon_size, :annealing_temperature, :extension_time, :num_cycles, :crispr_modification_id, :success
  json.url pcr_validation_url(pcr_validation, format: :json)
end
