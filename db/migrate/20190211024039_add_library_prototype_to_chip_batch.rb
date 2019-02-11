class AddLibraryPrototypeToChipBatch < ActiveRecord::Migration
  def change
    add_reference :chip_batches, :library_prototype, index: true
    add_foreign_key :chip_batches, :libraries, column: :library_prototype_id
  end
end
