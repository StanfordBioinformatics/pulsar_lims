class AddInsertionRegionToDonorConstructs < ActiveRecord::Migration
  def change
    add_column :donor_constructs, :insertion_region, :string
  end
end
