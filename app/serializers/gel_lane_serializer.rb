class GelLaneSerializer < ActiveModel::Serializer
  embed :ids
  self.root = false

  attributes :id, 
             :expected_product_size, 
             :lane_number, 
             :sample_concentration,
             :sample_volume,
             :notes,
             :pass,
             :submitter_comments,
             :created_at,
             :updated_at,
             :upstream_identifier


  has_one :gel
  has_one :biosample
  has_one :sample_concentration_units
  has_one :user
end
