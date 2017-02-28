class AddColToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :is_protocol, :boolean
  end
end
