class AddAddgeneIdToDonorConstructs < ActiveRecord::Migration
  def change
    add_column :donor_constructs, :addgene_id, :string
    add_index :donor_constructs, :addgene_id
  end
end
