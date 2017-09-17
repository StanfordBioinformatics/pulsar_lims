class SequencingRequestSerializer < ActiveModel::Serializer
  attributes :id, 
						 :user_id, 
						 :name, 
						 :comment,
 						 :shipped,
 						 :created_at,
 						 :updated_at,
 						 :paired_end,
 						 :concentration
	has_one :concentration_unit
	has_one :sequencing_center
	has_one :sequencing_platform
	has_many :sequencing_runs
end
