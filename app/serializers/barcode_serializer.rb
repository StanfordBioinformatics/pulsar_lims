class BarcodeSerializer < ActiveModel::Serializer
  attributes :id, :name, :sequence
  has_one :user
  has_one :sequencing_library_prep_kit
end
