class AddFieldsToPcr < ActiveRecord::Migration
  def change
    add_reference :pcrs, :analyst, index: true
    add_reference :pcrs, :biosample, index: true, foreign_key: true
    add_column :pcrs, :genomic_dna_prep_date, :date
    add_column :pcrs, :genomic_dna_concentration, :float
    add_reference :pcrs, :genomic_dna_concentration_units, index: true
    add_reference :pcrs, :document, index: true, foreign_key: true
    add_column :pcrs, :second_pcr_num_cycles, :integer
    add_foreign_key :pcrs, :users, column: :analyst_id
    add_foreign_key :pcrs, :units, column: :genomic_dna_concentration_units_id
  end
end
