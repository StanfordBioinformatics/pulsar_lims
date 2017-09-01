class AddOwnerToBiosample < ActiveRecord::Migration
  def change
    add_reference :biosamples, :owner, index: true
		add_foreign_key :biosamples, :users, column: :owner_id
  end
end
