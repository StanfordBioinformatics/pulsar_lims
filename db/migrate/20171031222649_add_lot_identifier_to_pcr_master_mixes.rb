class AddLotIdentifierToPcrMasterMixes < ActiveRecord::Migration
  def change
    add_column :pcr_master_mixes, :lot_identifier, :string
  end
end
