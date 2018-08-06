class ChangePercentageInGelsToBeString < ActiveRecord::Migration
  def change
    change_column :gels, :percentage, :string
  end
end
