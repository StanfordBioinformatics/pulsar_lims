class AddAntibodyToBatchItem < ActiveRecord::Migration
  def change
    add_reference :batch_items, :antibody, index: true, foreign_key: true
  end
end
