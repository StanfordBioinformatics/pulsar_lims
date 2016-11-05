require 'rails_helper'

RSpec.describe "sequencing_requests/index", type: :view do
  before(:each) do
    assign(:sequencing_requests, [
      SequencingRequest.create!(
        :name => "Name",
        :comment => "MyText",
        :sequencing_platform => nil,
        :sequencing_center => nil,
        :shipped => ""
      ),
      SequencingRequest.create!(
        :name => "Name",
        :comment => "MyText",
        :sequencing_platform => nil,
        :sequencing_center => nil,
        :shipped => ""
      )
    ])
  end

  it "renders a list of sequencing_requests" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
