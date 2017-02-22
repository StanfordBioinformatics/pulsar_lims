class RemoveColumnOntologyTermAccessionFromBiosamples < ActiveRecord::Migration
  def change
		remove_column(:biosamples,:ontology_term_accession)
  end
end
