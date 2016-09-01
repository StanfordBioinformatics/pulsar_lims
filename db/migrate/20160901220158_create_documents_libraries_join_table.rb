class CreateDocumentsLibrariesJoinTable < ActiveRecord::Migration
  def change
		create_table :documents_libraries, id: false do |t|
			t.integer :document_id, index: true
			t.integer :library_id, index: true
		end
  end
end
