class RemoveHumanGeneFromAntibodies < ActiveRecord::Migration
  def change
		remove_reference(:antibodies,:human_gene)
  end
end
