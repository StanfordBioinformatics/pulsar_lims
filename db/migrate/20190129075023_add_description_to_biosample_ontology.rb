class AddDescriptionToBiosampleOntology < ActiveRecord::Migration
  def change
    add_column :biosample_ontologies, :description, :text
  end
end
