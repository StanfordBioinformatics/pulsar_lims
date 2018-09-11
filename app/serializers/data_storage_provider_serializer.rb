class DataStorageProviderSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false

  attributes :id, 
             :bucket_storage,                                                                                       
             :name,                                                                                         
             :notes,                                                                                        
             :created_at,
             :updated_at

  has_one :user
end
