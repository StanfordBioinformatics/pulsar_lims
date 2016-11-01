class AddUserToDocuments < ActiveRecord::Migration
  def change
    add_reference :documents, :user, index: true
    add_foreign_key :documents, :users
  end
end
