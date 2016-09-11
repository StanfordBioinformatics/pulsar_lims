class RemoveStringFromDonors < ActiveRecord::Migration
  def change
		remove_column :donors, :string
  end
end
