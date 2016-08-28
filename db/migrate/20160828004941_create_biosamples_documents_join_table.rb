class CreateBiosamplesDocumentsJoinTable < ActiveRecord::Migration
  def change
		create_table :biosamples_documents, id: false do |t|
			t.integer :biosample_id, index: true
			t.integer :document_id, index: true
		end
  end
end
