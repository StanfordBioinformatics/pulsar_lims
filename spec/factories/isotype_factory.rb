
FactoryGirl.define do
	factory :isotype do
		sequence(:name) { |n| "isotype#{n}" }
	end
end
