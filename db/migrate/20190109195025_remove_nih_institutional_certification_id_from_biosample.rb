class RemoveNihInstitutionalCertificationIdFromBiosample < ActiveRecord::Migration
  def change
    remove_column :biosamples, :nih_institutional_certification_id, :integer
  end
end
