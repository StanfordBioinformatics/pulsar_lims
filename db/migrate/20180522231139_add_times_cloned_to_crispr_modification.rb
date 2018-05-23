class AddTimesClonedToCrisprModification < ActiveRecord::Migration
  def change
    add_column :crispr_modifications, :_times_cloned, :integer, default: 0
  end
end
