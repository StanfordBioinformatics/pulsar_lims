class PairedBarcodeSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false

  attributes :id,
             :name,
             :notes,
             :sequencing_library_prep_kit,
             :created_at,
             :updated_at

  # Dont serialize:
  # 1. sequencing_library_prep_kit
  has_one :index1 # Barcode association
  has_one :index2 # Barcode association
  has_one :user
end
