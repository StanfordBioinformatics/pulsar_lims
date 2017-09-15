class CreateJoinTableCrisprConstructsCrisprModifications < ActiveRecord::Migration
  def change
    create_join_table :crispr_constructs, :crispr_modifications do |t|
      # t.index [:crispr_construct_id, :crispr_modification_id]
      # t.index [:crispr_modification_id, :crispr_construct_id]
    end
    add_index :crispr_constructs_modifications, [:crispr_construct_id, :crispr_modification_id], name: "crispr_construct_crispr_mod"
    add_index :crispr_constructs_modifications, [:crispr_modification_id, :crispr_construct_id], name: "crispr_mod_crispr_construct"
  end
end
