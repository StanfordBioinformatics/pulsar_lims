class RemoveNotesFromNucleicAcidTerms < ActiveRecord::Migration
  def change
    remove_column :nucleic_acid_terms, :notes
  end
end
