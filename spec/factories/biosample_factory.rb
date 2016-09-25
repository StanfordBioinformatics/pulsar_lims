
FactoryGirl.define do
	factory :biosample do
		documents { [FactoryGirl.create(:document),FactoryGirl.create(:document)] }
		donor
		vendor
		biosample_type
		name "Exmaple biosample"
		submitter_comments "good biosample"
		lot_identifier "1"
		vendor_product_identifier "product 1"
		ontology_term_accession "EFO:0000962"
		ontology_term_name "skin"
		description "sample description"
		passage_number 3
	end
end
		
