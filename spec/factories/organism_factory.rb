
FactoryGirl.define do
	factory :organism do
		sequence(:name) { |n| "NR1I3#{n}" }
	end
end
