class AddNihInstitutionalCertificationToBiosamples < ActiveRecord::Migration
  def change
    add_reference :biosamples, :nih_institutional_certification, index: true
    add_foreign_key :biosamples, :documents, column: :nih_institutional_certification_id
  end
end
