class RenameSequenceOntologyTermsToNucleicAcidTerms < ActiveRecord::Migration
  def change
		rename_table :sequence_ontology_terms, :nucleic_acid_terms
  end
end
