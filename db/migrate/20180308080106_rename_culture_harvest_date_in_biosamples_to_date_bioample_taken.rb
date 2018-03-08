class RenameCultureHarvestDateInBiosamplesToDateBioampleTaken < ActiveRecord::Migration
  def change
    rename_column :biosamples, :culture_harvest_date, :date_biosample_taken
  end
end
