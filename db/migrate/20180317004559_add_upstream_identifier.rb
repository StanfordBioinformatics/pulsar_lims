class AddUpstreamIdentifier < ActiveRecord::Migration
  def change
    add_column :antibodies, :upstream_identifier, :string, unique: true                                
    add_column :crispr_modifications, :upstream_identifier, :string, unique: true                      
    add_column :documents, :upstream_identifier, :string, unique: true                                 
    add_column :libraries, :upstream_identifier, :string, unique: true                                 
    add_column :single_cell_sortings, :upstream_identifier, :string, unique: true                      
    add_column :vendors, :upstream_identifier, :string, unique: true                                   
    add_column :donors, :upstream_identifier, :string, unique: true                                    
    add_column :targets, :upstream_identifier, :string, unique: true                                   
    add_column :treatments, :upstream_identifier, :string, unique: true
  end
end
