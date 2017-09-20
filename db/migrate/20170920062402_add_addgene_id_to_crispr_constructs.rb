class AddAddgeneIdToCrisprConstructs < ActiveRecord::Migration
  def change
    add_column :crispr_constructs, :addgene_id, :string
    add_index :crispr_constructs, :addgene_id
  end
end
