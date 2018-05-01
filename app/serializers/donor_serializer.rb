class DonorSerializer < ActiveModel::Serializer
  self.root = false
  attributes :id, :age, :gender, :name, :upstream_identifier, :created_at, :updated_at
end
