class AddIndexOnSequencingRequestsName < ActiveRecord::Migration
  def change
		add_index(:sequencing_requests,:name,unique: true)
  end
end
