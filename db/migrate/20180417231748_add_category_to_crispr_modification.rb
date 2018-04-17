class AddCategoryToCrisprModification < ActiveRecord::Migration
  def change
    add_column :crispr_modifications, :category, :string
  end
end
