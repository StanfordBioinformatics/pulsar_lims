class AddSequencingRunFkeyToSequencingResult < ActiveRecord::Migration
  def change
    add_reference :sequencing_results, :sequencing_run, index: true, foreign_key: true
  end
end
