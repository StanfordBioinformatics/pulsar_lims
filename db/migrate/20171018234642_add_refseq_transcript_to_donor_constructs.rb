class AddRefseqTranscriptToDonorConstructs < ActiveRecord::Migration
  def change
    add_column :donor_constructs, :refseq_transcript, :string
  end
end
