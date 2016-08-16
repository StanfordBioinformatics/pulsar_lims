class CreateSequenceOntologyTerms < ActiveRecord::Migration
  def change
    create_table :sequence_ontology_terms do |t|
      t.string :name
      t.string :accession
      t.string :definition

      t.timestamps
    end
  end
end
