class RenameSequenceOntologyTermIdInLibrariesToNucleicAcidTermId < ActiveRecord::Migration
  def change
		rename_column :libraries, :sequence_ontology_term_id, :nucleic_acid_term_id
  end
end
