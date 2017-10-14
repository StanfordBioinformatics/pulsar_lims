class AddEnsemblToTargets < ActiveRecord::Migration
  def change
    add_column :targets, :ensembl, :string
  end
end
