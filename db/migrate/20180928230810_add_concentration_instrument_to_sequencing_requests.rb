class AddConcentrationInstrumentToSequencingRequests < ActiveRecord::Migration
  def change
    add_column :sequencing_requests, :concentration_instrument, :string
  end
end
