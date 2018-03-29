class RenameParentBiosampleIdToPartOfBiosampleIdInBiosamples < ActiveRecord::Migration
  def change
    rename_column :biosamples, :parent_biosample_id, :part_of_biosample_id
  end
end
