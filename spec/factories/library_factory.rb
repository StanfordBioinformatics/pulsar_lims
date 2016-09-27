
FactoryGirl.define do
	factory :library do
		user
		biosample
		antibody
		vendor
		nucleic_acid_term
		name "Example Library"
		size_range "450-650"
	end
end
