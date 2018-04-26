class BiosampleSerializer < ActiveModel::Serializer
  attributes :id, :passage_number, :starting_amount, :starting_amount_units, :submitter_comments, :tissue_preservation_method, :vendor_product_identifier

  has_one :biosample_term_name
  has_one :biosample_type
  has_one :crispr_modification
  has_one :donor
  has_one :vendor

  has_many :documents
  has_many :pooled_from_biosamples

  self.root = false
end
