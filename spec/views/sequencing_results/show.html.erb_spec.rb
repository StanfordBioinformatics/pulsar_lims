require 'rails_helper'

RSpec.describe "sequencing_results/show", type: :view do
  before(:each) do
    @sequencing_result = assign(:sequencing_result, SequencingResult.create!(
      :user => nil,
      :sequencing_request => nil,
      :run_name => "Run Name",
      :lane => 2,
      :comment => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Run Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
  end
end
