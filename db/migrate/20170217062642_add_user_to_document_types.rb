class AddUserToDocumentTypes < ActiveRecord::Migration
  def change
    add_reference :document_types, :user, index: true
    add_foreign_key :document_types, :users
  end
end
