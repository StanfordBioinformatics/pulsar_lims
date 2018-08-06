class RenameTableAgaroseGelToGel < ActiveRecord::Migration
  def change
    rename_table :agarose_gels, :gels
  end
end
