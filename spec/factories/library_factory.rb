
FactoryGirl.define do
	factory :library do
		name "Example Library"
		size_range "450-650"
		strand_specific true
		
		sequence(:email) { |n| "test#{n}@example.com" }
	end
end
