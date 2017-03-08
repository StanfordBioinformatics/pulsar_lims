class SequencingLibraryPrepKitSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  has_one :user
  has_one :vendor
end
