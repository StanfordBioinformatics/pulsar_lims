class AddColumnsToBiosample < ActiveRecord::Migration
  def change
    add_reference :biosamples, :biosample_term_name, index: true
    add_foreign_key :biosamples, :biosample_term_names
  end
end
