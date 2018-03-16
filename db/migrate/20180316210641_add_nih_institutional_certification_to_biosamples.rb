class AddNihInstitutionalCertificationToBiosamples < ActiveRecord::Migration
  def change
    add_column :biosamples, :nih_institutional_certification, :string
  end
end
