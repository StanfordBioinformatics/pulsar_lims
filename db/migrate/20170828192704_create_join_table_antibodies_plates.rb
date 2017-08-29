class CreateJoinTableAntibodiesPlates < ActiveRecord::Migration
  def change
    create_join_table :antibodies, :plates do |t|
       t.index [:antibody_id, :plate_id]
       t.index [:plate_id, :antibody_id]
    end
  end
end
