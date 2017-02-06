class AddIndexOnSequencingResultsName < ActiveRecord::Migration
  def change
		add_index(:sequencing_results, :name, unique: true)
  end
end
