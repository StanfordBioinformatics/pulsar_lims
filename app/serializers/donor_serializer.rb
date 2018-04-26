class DonorSerializer < ActiveModel::Serializer
  attributes :id, :age, :gender, :name, :upstream_identifier
end
