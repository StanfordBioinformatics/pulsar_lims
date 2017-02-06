class CreateLibrarySequencingResults < ActiveRecord::Migration
  def change
    create_table :library_sequencing_results do |t|
      t.string :name
      t.references :sequencing_result, index: true
      t.references :library, index: true
      t.text :comment
      t.string :read1_uri
      t.string :read2_uri
      t.integer :read1_count
      t.integer :read2_count

      t.timestamps null: false
    end
		add_index(:library_sequencing_results,:name,unique: true)
    add_foreign_key :library_sequencing_results, :sequencing_results
    add_foreign_key :library_sequencing_results, :libraries
  end
end
