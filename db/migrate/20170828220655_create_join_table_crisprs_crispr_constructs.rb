class CreateJoinTableCrisprsCrisprConstructs < ActiveRecord::Migration
  def change
    create_join_table :crisprs, :crispr_constructs do |t|
       #t.index [:crispr_id, :crispr_construct_id]
       #t.index [:crispr_construct_id, :crispr_id]
    end
		add_index :crispr_constructs_crisprs, [:crispr_id, :crispr_construct_id], name: "crispr_crispr_construct"
		add_index :crispr_constructs_crisprs, [:crispr_construct_id, :crispr_id], name: "crispr_construct_crispr"
  end
end
