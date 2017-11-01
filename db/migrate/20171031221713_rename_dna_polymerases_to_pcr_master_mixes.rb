class RenameDnaPolymerasesToPcrMasterMixes < ActiveRecord::Migration
  def change
		rename_table :dna_polymerases, :pcr_master_mixes
  end
end
