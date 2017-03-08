class CreateDocumentsSequencingLibraryPrepKitsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :documents, :sequencing_library_prep_kits
  end
end
