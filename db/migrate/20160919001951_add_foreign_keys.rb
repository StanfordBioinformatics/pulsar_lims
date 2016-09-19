class AddForeignKeys < ActiveRecord::Migration
  def change
		add_foreign_key :antibodies, :organisms
		add_foreign_key :antibodies, :vendors
		add_foreign_key :antibodies, :isotypes
		add_foreign_key :antibodies, :human_genes

		add_foreign_key :biosamples, :biosample_types
		add_foreign_key :biosamples, :donors
		add_foreign_key :biosamples, :vendors
		
		add_foreign_key :documents, :document_types

		add_foreign_key :libraries, :nucleic_acid_terms
		add_foreign_key :libraries, :biosamples
		add_foreign_key :libraries, :antibodies
		add_foreign_key :libraries, :vendors
  end
end
