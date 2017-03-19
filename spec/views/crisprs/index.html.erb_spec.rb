require 'rails_helper'

RSpec.describe "crisprs/index", type: :view do
  before(:each) do
    assign(:crisprs, [
      Crispr.create!(
        :name => "Name",
        :user => nil,
        :crispr_construct => nil,
        :donor_construct => nil,
        :biosample => nil
      ),
      Crispr.create!(
        :name => "Name",
        :user => nil,
        :crispr_construct => nil,
        :donor_construct => nil,
        :biosample => nil
      )
    ])
  end

  it "renders a list of crisprs" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
