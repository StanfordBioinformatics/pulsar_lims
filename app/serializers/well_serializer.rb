class WellSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false

  attributes :id,
             :col,
             :comment,
             :fail,
             :name,
             :plate_id, # No need to serialize this via has_one. 
             :row,
             :user,
             :created_at,
             :updated_at

has_one :biosample
end
