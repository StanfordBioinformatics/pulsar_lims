class BiosampleTypeSerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :updated_at, :user_id
end
