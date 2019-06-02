class GelSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false

  attributes :id, 
             :caption,
             :notes,
             :percentage,
             :run_date
             :voltage

  has_many :pcrs
  has_one :immunoblot
  has_one :user

  has_many :biosamples
  has_many :gel_lanes
  has_many :gel_images
end
