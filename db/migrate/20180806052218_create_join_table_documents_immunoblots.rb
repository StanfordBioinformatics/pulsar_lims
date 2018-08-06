class CreateJoinTableDocumentsImmunoblots < ActiveRecord::Migration
  def change
    create_join_table :documents, :immunoblots do |t|
      t.index [:document_id, :immunoblot_id]
      t.index [:immunoblot_id, :document_id]
    end
  end
end
