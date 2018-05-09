class TargetSerializer < ActiveModel::Serializer
  self.root = false
  attributes :id, :ensembl, :name, :notes, :refseq, :uniprotkb, :upstream_identifier, :created_at, :updated_at
end
