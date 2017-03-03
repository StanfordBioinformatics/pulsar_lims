class RemoveDefaultOnIsProtocolInDocuments < ActiveRecord::Migration
  def change
		change_column :documents, :is_protocol, :boolean, :default => nil
  end
end
