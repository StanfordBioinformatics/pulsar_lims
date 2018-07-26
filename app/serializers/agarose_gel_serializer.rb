class AgaroseGelSerializer < ActiveModel::Serializer
  self.root = true
  embed :ids

  attributes :id, 
             :notes
             :percent_agarose, 
             :run_date
             :voltage, 

  has_one :user
end
