require 'rails_helper'

RSpec.describe "wells/index", type: :view do
  before(:each) do
    assign(:wells, [
      Well.create!(
        :user => nil,
        :name => "Name",
        :plate => nil,
        :row => 2,
        :col => 3,
        :barcode => nil,
        :paired_barcode => nil,
        :fail => false,
        :comment => "MyText"
      ),
      Well.create!(
        :user => nil,
        :name => "Name",
        :plate => nil,
        :row => 2,
        :col => 3,
        :barcode => nil,
        :paired_barcode => nil,
        :fail => false,
        :comment => "MyText"
      )
    ])
  end

  it "renders a list of wells" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
