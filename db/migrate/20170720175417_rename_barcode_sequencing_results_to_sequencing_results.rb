class RenameBarcodeSequencingResultsToSequencingResults < ActiveRecord::Migration
  def change
		rename_table :barcode_sequencing_results, :sequencing_results
  end
end
