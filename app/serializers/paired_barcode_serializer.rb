class PairedBarcodeSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :user
  has_one :index1
  has_one :index2
  has_one :sequencing_library_prep_kit
end
