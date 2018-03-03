class CreateJoinTableDocumentsTreatments < ActiveRecord::Migration
  def change
    create_join_table :documents, :treatments do |t|
       t.index [:document_id, :treatment_id]
       t.index [:treatment_id, :document_id]
    end
  end
end
