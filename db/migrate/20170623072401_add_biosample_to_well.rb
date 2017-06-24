class AddBiosampleToWell < ActiveRecord::Migration
  def change
    add_reference :wells, :biosample, index: true
		add_foreign_key :wells, :biosamples
  end
end
