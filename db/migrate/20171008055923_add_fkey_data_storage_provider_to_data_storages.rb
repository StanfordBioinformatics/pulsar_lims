class AddFkeyDataStorageProviderToDataStorages < ActiveRecord::Migration
  def change
    add_reference :data_storages, :data_storage_provider, index: true, foreign_key: true
  end
end
