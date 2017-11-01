class PcrValidationSerializer < ActiveModel::Serializer
  attributes :id, :description, :forward_primer, :reverse_primer, :amplicon_size, :annealing_temperature, :extension_time, :num_cycles, :success
  has_one :user
  has_one :pcr_master_mix
  has_one :crispr_modification
end
