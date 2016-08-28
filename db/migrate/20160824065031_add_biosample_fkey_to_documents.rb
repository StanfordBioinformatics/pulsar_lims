class AddBiosampleFkeyToDocuments < ActiveRecord::Migration
  def change
    add_reference :documents, :biosample, index: true
  end
end
