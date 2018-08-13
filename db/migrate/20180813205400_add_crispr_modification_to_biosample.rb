class AddCrisprModificationToBiosample < ActiveRecord::Migration
  def change
    add_reference :biosamples, :crispr_modification, index: true, foreign_key: true
  end
end
