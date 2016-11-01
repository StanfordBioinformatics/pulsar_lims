class AddUserToNucleicAcidTerms < ActiveRecord::Migration
  def change
    add_reference :nucleic_acid_terms, :user, index: true
    add_foreign_key :nucleic_acid_terms, :users
  end
end
