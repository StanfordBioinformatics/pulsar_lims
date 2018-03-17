class RemoveUpstream < ActiveRecord::Migration
  def change
    remove_column :antibodies, :upstream                                                         
    remove_column :crispr_modifications, :upstream                                               
    remove_column :documents, :upstream                                                          
    remove_column :libraries, :upstream                                                          
    remove_column :single_cell_sortings, :upstream                                               
  end
end
