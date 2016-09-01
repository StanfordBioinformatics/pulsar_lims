class RenameTermIdentifierInBiosampleToOntologyTermName < ActiveRecord::Migration
  def change
		rename_column :biosamples, :term_name, :ontology_term_name
		rename_column :biosamples, :term_identifier, :ontology_term_accession
  end
end
