
FactoryGirl.define do
	factory :document do
		document_type
		content_type "application/pdf"
		data "stream"
		sequence(:name) { |n| "Example name #{n}" }
		description "Document description"
	end
end
		
