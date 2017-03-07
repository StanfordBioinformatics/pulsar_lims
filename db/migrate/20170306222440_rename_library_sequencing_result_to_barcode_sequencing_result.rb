class RenameLibrarySequencingResultToBarcodeSequencingResult < ActiveRecord::Migration
  def change
		rename_table :library_sequencing_results, :barcode_sequencing_results
  end
end
