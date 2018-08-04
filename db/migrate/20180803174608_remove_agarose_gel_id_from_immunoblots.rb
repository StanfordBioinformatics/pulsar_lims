class RemoveAgaroseGelIdFromImmunoblots < ActiveRecord::Migration
  def change
    remove_column :immunoblots, :agarose_gel_id
  end
end
