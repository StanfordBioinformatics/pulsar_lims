class ShippingSerializer < ActiveModel::Serializer
  self.root = false

  attributes :id, 
             :carrier, 
             :tracking_code,  
             :date_shipped, 
             :received,
             :created_at,                                                                              
             :updated_at

  has_one :biosample
  has_one :from
  has_one :to
  has_one :user
end
