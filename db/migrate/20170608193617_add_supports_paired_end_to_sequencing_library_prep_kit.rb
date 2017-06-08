class AddSupportsPairedEndToSequencingLibraryPrepKit < ActiveRecord::Migration
  def change
    add_column :sequencing_library_prep_kits, :supports_paired_end, :boolean
  end
end
