require 'rails_helper'

RSpec.describe "sequencing_centers/index", type: :view do
  before(:each) do
    assign(:sequencing_centers, [
      SequencingCenter.create!(
        :name => "Name",
        :address => "MyText"
      ),
      SequencingCenter.create!(
        :name => "Name",
        :address => "MyText"
      )
    ])
  end

  it "renders a list of sequencing_centers" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
