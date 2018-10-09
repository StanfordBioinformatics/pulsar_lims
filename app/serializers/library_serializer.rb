class LibrarySerializer < ActiveModel::Serializer
  embed :ids
  self.root = false

  attributes :id,
             :biosample_id, 
             :concentration,
             :dual_indexed,
             :from_prototype_id, 
             :lot_identifier,
             :name,
             :notes,
             :prototype,
             :upstream_identifier,
             :size_range,
             :strand_specific,
             :times_cloned,
             :vendor_product_identifier,
             :upstream_identifier,
             :created_at,
             :updated_at

  # Dont serialize the following associations:
  #    1. from_prototype_id
  #    2. biosample_id
  has_one :barcode
  has_one :concentration_unit
  has_one :library_fragmentation_method
  has_one :nucleic_acid_term
  has_one :paired_barcode
  has_one :sequencing_library_prep_kit
  has_one :single_cell_sorting
  has_one :vendor

  has_many :documents

end
