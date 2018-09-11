class DataStorageSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false

  attributes :id, 
             :bucket,                                                                                       
             :folder_base_path,                                                                             
             :name,                                                                                         
             :notes,                                                                                        
             :project_identifier,
             :created_at,
             :updated_at

  has_one :data_storage_provider
  has_one :user
end
