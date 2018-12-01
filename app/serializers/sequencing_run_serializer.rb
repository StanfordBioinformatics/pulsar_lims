class SequencingRunSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false

  attributes :id,
             :comment,
             :date_submitted,
             :forward_read_len,
             :lane,
             :name,
             :notes,
             :reverse_read_len,
             :status,
             :created_at,
             :updated_at

  has_one :report
  has_one :sequencing_request
  has_many :sequencing_results
  has_one :submitted_by
  has_one :data_storage
  has_one :user
end
