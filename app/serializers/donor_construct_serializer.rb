class DonorConstructSerializer < ActiveModel::Serializer
  self.root = false
  attributes :id, :addgene_id, :date_sent, :description, :donor_cell_line, :ensembl_transcript, :insert_sequence, :known_snps, :name, :primer_left_forward, :primer_left_reverse, :primer_right_forward, :primer_right_reverse, :refseq_transcript, :vendor_product_identifier, :notes, :created_at, :updated_at

  has_one :cloning_vector
  has_one :sent_to
  has_one :target
  has_one :vendor

  has_many :construct_tags
end
