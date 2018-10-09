class RenameSupportsPairedEndToSupportsDualIndexingInSequencingLibraryPrepKits < ActiveRecord::Migration
  def change
    rename_column :sequencing_library_prep_kits, :supports_paired_end, :supports_dual_indexing
  end
end
