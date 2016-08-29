class AddVendorFkeyToBiosamples < ActiveRecord::Migration
  def change
    add_reference :biosamples, :vendor, index: true
  end
end
