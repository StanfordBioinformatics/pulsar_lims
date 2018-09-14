class ImmunoblotSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false
  
  attributes :id, 
             :date_performed, 
             :name,
             :notes, 
             :primary_antibody_dilution,
             :secondary_antibody_dilution,
             :submitter_comments,
             :created_at,
             :updated_at

  has_one :analyst
  has_one :primary_antibody
  has_one :secondary_antibody
  has_one :user
end
