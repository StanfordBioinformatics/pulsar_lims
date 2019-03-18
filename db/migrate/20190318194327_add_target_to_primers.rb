class AddTargetToPrimers < ActiveRecord::Migration
  def change
    add_reference :primers, :target, index: true, foreign_key: true
  end
end
