require 'rails_helper'

RSpec.describe "donor_constructs/show", type: :view do
  before(:each) do
    @donor_construct = assign(:donor_construct, DonorConstruct.create!(
      :name => "Name",
      :user => nil,
      :cloning_vector => nil,
      :vender => nil,
      :vender_product_identifier => "Vender Product Identifier",
      :target => nil,
      :description => "MyText",
      :insert_sequence => "MyText",
      :promoter => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Vender Product Identifier/)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
  end
end
