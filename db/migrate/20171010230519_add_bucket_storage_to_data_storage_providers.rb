class AddBucketStorageToDataStorageProviders < ActiveRecord::Migration
  def change
    add_column :data_storage_providers, :bucket_storage, :boolean, default: false
  end
end
