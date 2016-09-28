
FactoryGirl.define do
	factory :antibody do
		organism
		vendor
		isotype
		human_gene
		sequence(:name) { |n| "antibody#{n}" }
		antibody_purifications { [FactoryGirl.create(:antibody_purification),FactoryGirl.create(:antibody_purification)] }
		vendor_product_identifier "product 1"
		lot_identifier "lot 1"
		clonality "monoclonal"
	end
end
		
