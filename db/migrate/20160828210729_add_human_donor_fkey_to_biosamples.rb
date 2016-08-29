class AddHumanDonorFkeyToBiosamples < ActiveRecord::Migration
  def change
    add_reference :biosamples, :human_donor, index: true
  end
end
