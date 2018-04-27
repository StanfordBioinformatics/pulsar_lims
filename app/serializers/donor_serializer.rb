class DonorSerializer < ActiveModel::Serializer
  attributes :id, :age, :gender, :name, :upstream_identifier, :created_at, :updated_at
end
