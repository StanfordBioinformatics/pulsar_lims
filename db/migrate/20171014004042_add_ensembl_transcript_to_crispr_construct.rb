class AddEnsemblTranscriptToCrisprConstruct < ActiveRecord::Migration
  def change
    add_column :crispr_constructs, :ensembl_transcript, :string
  end
end
