class FileReferenceSerializer < ActiveModel::Serializer
  attributes :id, :file_path, :fileid
  has_one :user
  has_one :data_storage
end
