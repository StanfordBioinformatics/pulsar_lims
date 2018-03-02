class CreateJoinTableBiosamplesTreatments < ActiveRecord::Migration
  def change
    create_join_table :biosamples, :treatments do |t|
      t.index [:biosample_id, :treatment_id]
      t.index [:treatment_id, :biosample_id]
    end
  end
end
