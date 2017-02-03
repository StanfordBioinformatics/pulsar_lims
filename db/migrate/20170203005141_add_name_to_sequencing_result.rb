class AddNameToSequencingResult < ActiveRecord::Migration
  def change
    add_column :sequencing_results, :name, :string, index: true, unique: true
  end
end
