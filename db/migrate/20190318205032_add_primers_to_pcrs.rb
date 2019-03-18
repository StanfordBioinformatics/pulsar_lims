class AddPrimersToPcrs < ActiveRecord::Migration
  def change
    add_reference :pcrs, :forward_primer, index: true
    add_reference :pcrs, :reverse_primer, index: true
    add_foreign_key :pcrs, :primers, column: :forward_primer_id
    add_foreign_key :pcrs, :primers, column: :reverse_primer_id
  end
end
