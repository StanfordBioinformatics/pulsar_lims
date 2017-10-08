class SequencingRunSerializer < ActiveModel::Serializer
  attributes :id, :lane, :comment
  has_one :user
end
