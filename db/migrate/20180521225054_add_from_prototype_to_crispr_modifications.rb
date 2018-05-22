class AddFromPrototypeToCrisprModifications < ActiveRecord::Migration
  def change
    add_reference :crispr_modifications, :from_prototype, index: true
    add_foreign_key :crispr_modifications, :crispr_modifications, column: :from_prototype_id 
  end
end
