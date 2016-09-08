FactoryGirl.define do

	factory :organism do 
		name "Bob " + Time.now.to_s
	end

	factory :vendor do 
		name "Vendor " + Time.now.to_s
		title "vendor title"
		description "desc"
	end

	factory :isotype do
		name "isotype name " + Time.now.to_s
	end

	factory :human_gene do 
		name "gene " + Time.now.to_s
		encode_identifier "ENC " + Time.now.to_s
	end

	factory :antibody_purification do
		name "ab pur " + Time.now.to_s
	end

	factory :antibody do
		name "Example namee"
		organism FactoryGirl.create(:organism)
		vendor FactoryGirl.create(:vendor)
		isotype FactoryGirl.create(:isotype)
		human_gene FactoryGirl.create(:human_gene)
		antibody_purifications {[FactoryGirl.create(:antibody_purification)]}
		vendor_product_identifier "default prod 1"
		vendor_product_url "http://default/url.com"
		lot_identifier "default lot 1"
		clonality "monoclonal"
		antigen_description "default antigen description"
		antigen_sequence "ACGTN"
		
	end
end
