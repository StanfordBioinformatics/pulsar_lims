class AddBiosampleToBiosample < ActiveRecord::Migration
  def change
    add_reference :biosamples, :parent_biosample, index: true
    add_foreign_key :biosamples, :biosamples, column: :parent_biosample_id
  end
end
