class AddUserToLibrarySequencingResult < ActiveRecord::Migration
  def change
    add_reference :library_sequencing_results, :user, index: true
    add_foreign_key :library_sequencing_results, :users
  end
end
