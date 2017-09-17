class SequencingRunSerializer < ActiveModel::Serializer
  attributes :id, :run_name, :lane, :comment
  has_one :user
end
