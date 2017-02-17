class CrisprGeneticModificationSerializer < ActiveModel::Serializer
  attributes :id, :name, :vendor_product_identifier, :guide_rna_sequences, :insert_sequence
  has_one :user
  has_one :vendor
end
