class AddWellToBiosample < ActiveRecord::Migration
  def change
    add_reference :biosamples, :well, index: true, foreign_key: true
  end
end
