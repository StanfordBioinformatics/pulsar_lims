class GelImageSerializer < ActiveModel::Serializer
  attributes :id, :film_exposure_time, :image
  has_one :user
  has_one :gel
end
