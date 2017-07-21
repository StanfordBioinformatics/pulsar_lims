class RemoveSequencingResultIdFromSequencingResult < ActiveRecord::Migration
  def change
		remove_column :sequencing_results, :sequencing_result_id
  end
end
