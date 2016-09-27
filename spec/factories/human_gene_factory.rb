
FactoryGirl.define do
	factory :human_gene do
		name "NR1I3"
		sequence(:encode_identifier) { |e| "NR1I3#{e}-human" }
	end
end
