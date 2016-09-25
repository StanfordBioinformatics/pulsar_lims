
FactoryGirl.define do
	factory :donor do
		sequence(:encode_identifier) { |s|  "ENCDO000AAB#{s}" }
	end
end
		
