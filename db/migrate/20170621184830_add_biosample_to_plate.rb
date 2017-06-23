class AddBiosampleToPlate < ActiveRecord::Migration
  def change
    add_reference :plates, :starting_biosample, index: true
    add_foreign_key :plates, :biosamples, column:  :starting_biosample_id
  end
end
