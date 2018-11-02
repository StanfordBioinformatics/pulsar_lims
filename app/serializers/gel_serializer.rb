class GelSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false

  attributes :id, 
             :caption,
             :gel_image,
             :notes,
             :pcr_id,
             :percentage,
             :run_date
             :voltage

  has_one :pcr
  has_one :immunoblot
  has_one :user
end
