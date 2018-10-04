class ChipBatchSerializer < ActiveModel::Serializer
  attributes :id, 
             :crosslinking_method, 
             :date

  has_one :analyst
  has_one :user
end
