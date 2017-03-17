require 'rails_helper'

RSpec.describe "construct_tags/index", type: :view do
  before(:each) do
    assign(:construct_tags, [
      ConstructTag.create!(
        :user => nil,
        :name => "Name",
        :description => "MyText"
      ),
      ConstructTag.create!(
        :user => nil,
        :name => "Name",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of construct_tags" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
