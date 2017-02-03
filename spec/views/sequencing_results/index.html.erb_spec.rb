require 'rails_helper'

RSpec.describe "sequencing_results/index", type: :view do
  before(:each) do
    assign(:sequencing_results, [
      SequencingResult.create!(
        :user => nil,
        :sequencing_request => nil,
        :run_name => "Run Name",
        :lane => 2,
        :comment => "MyText"
      ),
      SequencingResult.create!(
        :user => nil,
        :sequencing_request => nil,
        :run_name => "Run Name",
        :lane => 2,
        :comment => "MyText"
      )
    ])
  end

  it "renders a list of sequencing_results" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Run Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
