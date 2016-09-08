FactoryGirl.define do
	factory :antibody do
		name "Example name"
		organism_id "1"
		vendor_id "1"
		isotype_id "1"
		human_gene_id "1"
		antibody_purifications = ["4","6"]
		vendor_product_identifier "default prod 1"
		vendor_product_url "http://default/url.com"
		lot_identifier "default lot 1"
		clonality "monoclonal"
		antigen_description "default antigen description"
		antigen_sequence "ACGTN"
		
	end
end
