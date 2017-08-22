class AddConcentrationUnitToSequencingRequest < ActiveRecord::Migration
  def change
    add_reference :sequencing_requests, :concentration_unit, index: true, foreign_key: true
  end
end
