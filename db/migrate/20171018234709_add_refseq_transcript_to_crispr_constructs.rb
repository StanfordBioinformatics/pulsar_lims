class AddRefseqTranscriptToCrisprConstructs < ActiveRecord::Migration
  def change
    add_column :crispr_constructs, :refseq_transcript, :string
  end
end
