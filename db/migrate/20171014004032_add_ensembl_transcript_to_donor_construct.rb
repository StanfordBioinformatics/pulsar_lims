class AddEnsemblTranscriptToDonorConstruct < ActiveRecord::Migration
  def change
    add_column :donor_constructs, :ensembl_transcript, :string
  end
end
