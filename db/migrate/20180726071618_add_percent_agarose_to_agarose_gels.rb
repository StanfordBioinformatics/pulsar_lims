class AddPercentAgaroseToAgaroseGels < ActiveRecord::Migration
  def change
    add_column :agarose_gels, :percent_agarose, :float
  end
end
