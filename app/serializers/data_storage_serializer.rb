class DataStorageSerializer < ActiveModel::Serializer
  attributes :id, :name, :bucket, :project_identifier, :folder_base_path
  has_one :user
end
