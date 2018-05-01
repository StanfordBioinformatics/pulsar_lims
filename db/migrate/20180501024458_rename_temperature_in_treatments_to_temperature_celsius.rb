class RenameTemperatureInTreatmentsToTemperatureCelsius < ActiveRecord::Migration
  def change
    rename_column :treatments, :temperature, :temperature_celsius
  end
end
