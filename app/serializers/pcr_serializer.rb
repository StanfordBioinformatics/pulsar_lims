class PcrSerializer < ActiveModel::Serializer
  self.root = false

  attributes :id, :name, :description, :notes, :amplicon_size, :biosample_id, :document_id, :gel_id, :reverse_primer_id, :pcr_master_mix_id, :forward_primer_id

  has_one :user
  has_one :gel
  has_one :forward_primer
  has_one :reverse_primer
 # has_one :biosample

end 
