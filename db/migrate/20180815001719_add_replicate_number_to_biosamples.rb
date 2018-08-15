class AddReplicateNumberToBiosamples < ActiveRecord::Migration
  def change
    add_column :biosamples, :replicate_number, :integer
  end
end
