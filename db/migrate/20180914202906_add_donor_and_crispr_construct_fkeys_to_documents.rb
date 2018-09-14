class AddDonorAndCrisprConstructFkeysToDocuments < ActiveRecord::Migration
  def change
    add_reference :documents, :crispr_construct, index: true, foreign_key: true
    add_reference :documents, :donor_construct, index: true, foreign_key: true
  end
end
