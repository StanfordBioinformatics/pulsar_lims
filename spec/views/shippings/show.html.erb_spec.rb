require 'rails_helper'

RSpec.describe "shippings/show", type: :view do
  before(:each) do
    @shipping = assign(:shipping, Shipping.create!(
      :user => nil,
      :carrier => "Carrier",
      :tracking_code => "Tracking Code",
      :received => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Carrier/)
    expect(rendered).to match(/Tracking Code/)
    expect(rendered).to match(/false/)
  end
end
