class AtacseqSerializer < ActiveModel::Serializer
  embed :ids                                                                                           
  self.root = false 

  attributes :id, 
             :description, 
             :name, 
             :notes,
             :single_cell,
             :submitter_comments,
             :upstream_identifier,
             :updated_at,
             :created_at

  has_one :user
  has_many :documents
  has_many :replicates
end
