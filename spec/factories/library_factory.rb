
FactoryGirl.define do
	factory :library do
		user
		documents { [FactoryGirl.create(:document),FactoryGirl.create(:document)] }
		biosample
		antibody
		vendor
		nucleic_acid_term
		name "Example Library"
		size_range "450-650"
	end
end
