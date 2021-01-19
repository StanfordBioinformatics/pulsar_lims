class RenameSuccessToSangerSequencingSuccessInPcr < ActiveRecord::Migration
  def change
    rename_column :pcrs, :success, :sanger_sequencing_success
  end
end
