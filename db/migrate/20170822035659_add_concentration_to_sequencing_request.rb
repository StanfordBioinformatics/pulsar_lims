class AddConcentrationToSequencingRequest < ActiveRecord::Migration
  def change
    add_column :sequencing_requests, :concentration, :float
  end
end
