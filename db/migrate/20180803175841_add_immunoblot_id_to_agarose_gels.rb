class AddImmunoblotIdToAgaroseGels < ActiveRecord::Migration
  def change
    add_reference :agarose_gels, :immunoblot, index: true, foreign_key: true
  end
end
