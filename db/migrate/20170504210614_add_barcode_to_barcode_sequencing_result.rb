class AddBarcodeToBarcodeSequencingResult < ActiveRecord::Migration
  def change
    add_reference :barcode_sequencing_results, :barcode, index: true, foreign_key: true
    add_reference :barcode_sequencing_results, :paired_barcode, index: true, foreign_key: true
  end
end
