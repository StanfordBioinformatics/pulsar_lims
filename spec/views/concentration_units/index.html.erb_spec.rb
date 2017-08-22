require 'rails_helper'

RSpec.describe "concentration_units/index", type: :view do
  before(:each) do
    assign(:concentration_units, [
      ConcentrationUnit.create!(
        :name => "Name",
        :user => nil
      ),
      ConcentrationUnit.create!(
        :name => "Name",
        :user => nil
      )
    ])
  end

  it "renders a list of concentration_units" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
