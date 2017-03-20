class RemoveDonorConstructIdFromConstructTag < ActiveRecord::Migration
  def change
		remove_column :construct_tags, :donor_construct_id
  end
end
