
FactoryGirl.define do
	factory :vendor do
		sequence(:name) { |n| "vendor#{n}" }
		title "examplevendor"
	end
end
		
