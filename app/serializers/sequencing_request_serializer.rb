class SequencingRequestSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false

  attributes :id,
        :average_size,
        :concentration,
        :date_submitted,
        :name,
        :notes,
        :paired_end,
        :sample_sheet

  has_one :concentration_unit
  has_one :sequencing_center
  has_one :sequencing_platform
  has_one :submitted_by
  has_one :user
  has_many :libraries
  has_many :plates
  has_many :sequencing_runs
  
end
