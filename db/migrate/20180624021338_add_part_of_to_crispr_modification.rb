class AddPartOfToCrisprModification < ActiveRecord::Migration
  def change
    add_reference :crispr_modifications, :part_of
    add_foreign_key :crispr_modifications, :crispr_modifications, column: :part_of_id
  end
end
