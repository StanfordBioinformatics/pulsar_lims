class AddBiosampleTypeFkeyToBiosamples < ActiveRecord::Migration
  def change
    add_reference :biosamples, :biosample_type, index: true
  end
end
