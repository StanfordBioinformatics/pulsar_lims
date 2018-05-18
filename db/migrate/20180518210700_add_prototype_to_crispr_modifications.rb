class AddPrototypeToCrisprModifications < ActiveRecord::Migration
  def change
    add_column :crispr_modifications, :prototype, :boolean
  end
end
