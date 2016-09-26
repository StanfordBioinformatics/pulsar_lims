
FactoryGirl.define do
	factory :donor do
		sequence(:encode_identifier) { |s|  "ENCIDO000AAB#{s}" }
		sequence(:encode_alias) { |a| "ENCID alias#{a}" }
	end
end
		
