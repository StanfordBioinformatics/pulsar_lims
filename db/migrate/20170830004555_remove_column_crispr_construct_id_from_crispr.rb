class RemoveColumnCrisprConstructIdFromCrispr < ActiveRecord::Migration
  def change
		remove_column :crisprs, :crispr_construct_id
  end
end
