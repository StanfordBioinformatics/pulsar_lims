class RenamePartOfBiosampleToPartOfInBiosamples < ActiveRecord::Migration
  def change
    rename_column :biosamples, :part_of_biosample_id, :part_of_id
  end
end
