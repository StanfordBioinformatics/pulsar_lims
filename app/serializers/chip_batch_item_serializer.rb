class ChipBatchItemSerializer < ActiveModel::Serializer
  attributes :id, :concentration, :notes
  has_one :user
  has_one :chip_batch
  has_one :biosample
end
