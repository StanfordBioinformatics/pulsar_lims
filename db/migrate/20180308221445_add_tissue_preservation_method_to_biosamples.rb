class AddTissuePreservationMethodToBiosamples < ActiveRecord::Migration
  def change
    add_column :biosamples, :tissue_preservation_method, :string
  end
end
