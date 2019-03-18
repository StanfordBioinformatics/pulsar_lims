class CreateJoinTablePrimersMatePrimers < ActiveRecord::Migration
  def change
    create_table :primers_mate_primers, id: false  do |t|
      t.integer :primer_id
      t.integer :mate_primer_id
    end
  end
end
