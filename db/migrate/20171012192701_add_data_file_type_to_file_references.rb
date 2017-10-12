class AddDataFileTypeToFileReferences < ActiveRecord::Migration
  def change
    add_reference :file_references, :data_file_type, index: true, foreign_key: true
  end
end
