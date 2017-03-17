class AddFkToLibrary < ActiveRecord::Migration
  def change
    add_reference :libraries, :sequencing_library_prep_kit, index: true, foreign_key: true
  end
end
