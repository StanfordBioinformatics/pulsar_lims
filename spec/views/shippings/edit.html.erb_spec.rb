require 'rails_helper'

RSpec.describe "shippings/edit", type: :view do
  before(:each) do
    @shipping = assign(:shipping, Shipping.create!(
      :user => nil,
      :carrier => "MyString",
      :tracking_code => "MyString",
      :received => false
    ))
  end

  it "renders the edit shipping form" do
    render

    assert_select "form[action=?][method=?]", shipping_path(@shipping), "post" do

      assert_select "input#shipping_user_id[name=?]", "shipping[user_id]"

      assert_select "input#shipping_carrier[name=?]", "shipping[carrier]"

      assert_select "input#shipping_tracking_code[name=?]", "shipping[tracking_code]"

      assert_select "input#shipping_received[name=?]", "shipping[received]"
    end
  end
end
