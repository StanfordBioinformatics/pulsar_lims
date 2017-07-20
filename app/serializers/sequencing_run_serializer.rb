class SequencingRunSerializer < ActiveModel::Serializer
  attributes :id, :run_name, :lane, :comment
  has_one :user
  has_one :sequencing_request
end
