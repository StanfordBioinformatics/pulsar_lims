class RenameSuccessToSangerSequencingSuccessInPcr < ActiveRecord::Migration
  def change
    rename_column :pcr, :success, :sanger_sequencing_success
  end
end
