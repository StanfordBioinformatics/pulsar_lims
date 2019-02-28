class GelImageSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false 

  attributes :id, 
             :film_exposure_time, 
             :image

  has_one :user
  has_one :gel
end
