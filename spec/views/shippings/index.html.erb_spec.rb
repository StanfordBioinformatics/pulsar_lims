require 'rails_helper'

RSpec.describe "shippings/index", type: :view do
  before(:each) do
    assign(:shippings, [
      Shipping.create!(
        :user => nil,
        :carrier => "Carrier",
        :tracking_code => "Tracking Code",
        :received => false
      ),
      Shipping.create!(
        :user => nil,
        :carrier => "Carrier",
        :tracking_code => "Tracking Code",
        :received => false
      )
    ])
  end

  it "renders a list of shippings" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Carrier".to_s, :count => 2
    assert_select "tr>td", :text => "Tracking Code".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
