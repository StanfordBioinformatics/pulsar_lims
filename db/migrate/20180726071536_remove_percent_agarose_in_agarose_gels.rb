class RemovePercentAgaroseInAgaroseGels < ActiveRecord::Migration
  def change
    remove_column :agarose_gels, :percent_agarose
  end
end
