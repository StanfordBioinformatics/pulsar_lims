class RenamePcrValidationToPcr < ActiveRecord::Migration
  def change
		rename_table :pcr_validations, :pcrs
  end
end
