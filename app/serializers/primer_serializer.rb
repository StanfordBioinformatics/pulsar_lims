class PrimerSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :notes, :direction, :sequence, :melting_temperature, :date_ordered
  has_one :user
end
