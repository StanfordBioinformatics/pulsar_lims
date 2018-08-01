class AgaroseGelSerializer < ActiveModel::Serializer
  self.root = true
  embed :ids

  attributes :id, 
             :gel_image,
             :notes,
             :percent_agarose, 
             :run_date
             :voltage

  has_one :user
end
