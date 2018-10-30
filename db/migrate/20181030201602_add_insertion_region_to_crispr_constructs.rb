class AddInsertionRegionToCrisprConstructs < ActiveRecord::Migration
  def change
    add_column :crispr_constructs, :insertion_region, :string
  end
end
