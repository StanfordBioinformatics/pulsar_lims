require 'rails_helper'

RSpec.describe "genome_locations/index", type: :view do
  before(:each) do
    assign(:genome_locations, [
      GenomeLocation.create!(
        :name => "Name",
        :user => nil,
        :chromosome => nil,
        :start => 2,
        :end => 3
      ),
      GenomeLocation.create!(
        :name => "Name",
        :user => nil,
        :chromosome => nil,
        :start => 2,
        :end => 3
      )
    ])
  end

  it "renders a list of genome_locations" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
