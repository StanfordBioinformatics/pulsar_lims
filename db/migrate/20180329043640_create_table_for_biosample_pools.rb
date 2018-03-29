class CreateTableForBiosamplePools < ActiveRecord::Migration
  def change
    create_table :biosamples_pooled_from_biosamples, id: false  do |t|
      t.integer :biosample_id
      t.integer :pooled_from_biosample_id
    end
    #add_index :biosample_pools_pooled_from_biosamples, [:biosample_pool_id, :pooled_from_biosample_id], name: "biosample_pool_idx"
    #add_index :biosample_pools_pooled_from_biosamples, [:pooled_from_biosample_id, :biosample_pool_id], name: "pooled_from_biosample_idx"
  end
end
