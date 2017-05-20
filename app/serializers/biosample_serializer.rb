class BiosampleSerializer < ActiveModel::Serializer
  attributes :id, :submitter_comments, :lot_identifier, :vendor_product_identifier, :description, :passage_number, :culture_harvest_date, :encid, :created_at, :updated_at, :name, :donor_id, :user_id, :biosample_term_name_id, :control

	has_one :vendor
	has_one :biosample_type
end
