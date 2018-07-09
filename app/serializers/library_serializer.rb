class LibrarySerializer < ActiveModel::Serializer
  self.root = false
  attributes :id, :concentration, :lot_identifier, :name, :notes, :upstream_identifier, :paired_end, :prototype, :size_range, :strand_specific, :vendor_product_identifier, :upstream_identifier, :created_at, :updated_at

  has_one :barcode
  has_one :biosample
  has_one :concentration_unit
  has_one :from_prototype
  has_one :library_fragmentation_method
  has_one :nucleic_acid_term
  has_one :paired_barcode
  has_one :sequencing_library_prep_kit
  has_one :vendor

  has_many :documents



end
