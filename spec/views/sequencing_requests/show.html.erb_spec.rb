require 'rails_helper'

RSpec.describe "sequencing_requests/show", type: :view do
  before(:each) do
    @sequencing_request = assign(:sequencing_request, SequencingRequest.create!(
      :name => "Name",
      :comment => "MyText",
      :sequencing_platform => nil,
      :sequencing_center => nil,
      :shipped => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
