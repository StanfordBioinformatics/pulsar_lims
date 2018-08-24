class ShippingSerializer < ActiveModel::Serializer
  self.root = false

  attributes :id, 
             :biosample_id,
             :carrier, 
             :tracking_code,  
             :date_shipped, 
             :received,
             :created_at,                                                                              
             :updated_at

  # Don't serialize
  # 1) biosample_id
  has_one :from
  has_one :to
  has_one :user
end
