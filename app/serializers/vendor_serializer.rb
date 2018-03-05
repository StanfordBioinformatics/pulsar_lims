class VendorSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :created_at, :updated_at, :url, :user_id, :upstream
end
