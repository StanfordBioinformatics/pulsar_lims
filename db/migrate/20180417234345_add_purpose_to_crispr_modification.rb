class AddPurposeToCrisprModification < ActiveRecord::Migration
  def change
    add_column :crispr_modifications, :purpose, :string
  end
end
