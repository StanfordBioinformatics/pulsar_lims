class RemoveSequencingLibraryPrepKitFromPlates < ActiveRecord::Migration
  def change
		remove_column :plates, :sequencing_library_prep_kit_id
  end
end
