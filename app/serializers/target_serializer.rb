class TargetSerializer < ActiveModel::Serializer
  self.root = false
 
  attributes :id, 
             :ensembl, 
             :name, 
             :notes, 
             :refseq, 
             :uniprotkb, 
             :upstream_identifier,
             :created_at,
             :updated_at

  has_one  :user
  has_many :antibodies
  has_many :crispr_constructs
  has_many :donor_constructs

end
