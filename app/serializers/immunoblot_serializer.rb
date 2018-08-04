class ImmunoblotSerializer < ActiveModel::Serializer
  self.root = false
  embed :ids
  
  attributes :id, 
             :date_performed, 
             :submitter_comments,
             :notes, 
             :created_at,
             :updated_at

  has_one :analyst
  has_one :primary_antibody
  has_one :primary_antibody_concentration
  has_one :primary_antibody_concentration_units
  has_one :secondary_antibody
  has_one :secondary_antibody_concentration
  has_one :secondary_antibody_concentration_units
  has_one :user
end
