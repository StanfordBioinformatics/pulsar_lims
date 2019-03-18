require 'rails_helper'

RSpec.describe "primers/index", type: :view do
  before(:each) do
    assign(:primers, [
      Primer.create!(
        :user => nil,
        :name => "Name",
        :description => "MyText",
        :notes => "MyText",
        :direction => "Direction",
        :sequence => "Sequence",
        :melting_temperature => "Melting Temperature"
      ),
      Primer.create!(
        :user => nil,
        :name => "Name",
        :description => "MyText",
        :notes => "MyText",
        :direction => "Direction",
        :sequence => "Sequence",
        :melting_temperature => "Melting Temperature"
      )
    ])
  end

  it "renders a list of primers" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Direction".to_s, :count => 2
    assert_select "tr>td", :text => "Sequence".to_s, :count => 2
    assert_select "tr>td", :text => "Melting Temperature".to_s, :count => 2
  end
end
