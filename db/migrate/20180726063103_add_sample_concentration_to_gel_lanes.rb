class AddSampleConcentrationToGelLanes < ActiveRecord::Migration
  def change
    add_column :gel_lanes, :sample_concentration, :string
    add_reference :gel_lanes, :sample_concentration_units, index: true
    add_foreign_key :gel_lanes, :concentration_units, column: :sample_concentration_units_id
  end
end
