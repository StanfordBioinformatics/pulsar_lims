class RenamePercentAgaroseInGelsToPercentage < ActiveRecord::Migration
  def change
    rename_column :gels, :percent_agarose, :percentage
  end
end
