class RemoveColumnOntologyTermNameFromBiosamples < ActiveRecord::Migration
  def change
		remove_column(:biosamples,:ontology_term_name)
  end
end
