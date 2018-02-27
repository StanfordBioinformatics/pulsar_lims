class AddNcbiTaxonToOrganism < ActiveRecord::Migration
  def change
    add_column :organisms, :ncbi_taxon, :string
  end
end
