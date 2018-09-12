class AddMergedToSequencingResult < ActiveRecord::Migration
  def change
    add_column :sequencing_results, :merged, :boolean
  end
end
