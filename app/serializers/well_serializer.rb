class WellSerializer < ActiveModel::Serializer
  self.root = false

  attributes :id,
             :col,
             :comment,
             :fail,
             :name,
             :plate_id, # No need to serialize this via has_one. 
             :row,
             :created_at,
             :updated_at

  has_one :biosample
  has_one :user
end
