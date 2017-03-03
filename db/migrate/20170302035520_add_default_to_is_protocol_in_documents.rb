class AddDefaultToIsProtocolInDocuments < ActiveRecord::Migration
  def change
		change_column :documents, :is_protocol, :boolean, :default => false
  end
end
