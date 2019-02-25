class GelSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false

  attributes :id, 
             :caption,
             :notes,
             :pcr_id,
             :percentage,
             :run_date
             :voltage

  has_one :pcr
  has_one :immunoblot
  has_one :user

  has_many :gel_images
end
