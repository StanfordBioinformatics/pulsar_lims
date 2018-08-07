class ImmunoblotSerializer < ActiveModel::Serializer
  self.root = false
  embed :ids
  
  attributes :id, 
             :date_performed, 
             :submitter_comments,
             :notes, 
             :primary_antibody_dilution,
             :secondary_antibody_dilution,
             :created_at,
             :updated_at

  has_one :analyst
  has_one :primary_antibody
  has_one :secondary_antibody
  has_one :user
end
