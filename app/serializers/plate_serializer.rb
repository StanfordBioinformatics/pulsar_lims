class PlateSerializer < ActiveModel::Serializer
  self.root = false

  attributes :id,
             :dimensions,
             :name,
             :notes,
             :single_cell_sorting_id, # Keep this here, rather than in has_one since we don't need this as a nested object.
             :vendor_id, # Same for vendor.
             :vendor_product_identifier,
             :created_at,
             :updated_at

  has_one :user

  has_many :antibodies
  has_many :wells
end
