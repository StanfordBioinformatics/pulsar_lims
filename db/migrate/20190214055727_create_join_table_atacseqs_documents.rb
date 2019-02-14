class CreateJoinTableAtacseqsDocuments < ActiveRecord::Migration
  def change
    create_join_table :atacseqs, :documents do |t|
      t.index [:atacseq_id, :document_id]
      t.index [:document_id, :atacseq_id]
    end
  end
end
