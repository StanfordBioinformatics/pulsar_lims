class AddConcentrationUnitToChipBatchItems < ActiveRecord::Migration
  def change
    add_reference :chip_batch_items, :concentration_unit, index: true
    add_foreign_key :chip_batch_items, :units, column: :concentration_unit_id
  end
end
