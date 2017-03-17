require 'rails_helper'

RSpec.describe "donor_constructs/index", type: :view do
  before(:each) do
    assign(:donor_constructs, [
      DonorConstruct.create!(
        :name => "Name",
        :user => nil,
        :cloning_vector => nil,
        :vender => nil,
        :vender_product_identifier => "Vender Product Identifier",
        :target => nil,
        :description => "MyText",
        :insert_sequence => "MyText",
        :promoter => nil
      ),
      DonorConstruct.create!(
        :name => "Name",
        :user => nil,
        :cloning_vector => nil,
        :vender => nil,
        :vender_product_identifier => "Vender Product Identifier",
        :target => nil,
        :description => "MyText",
        :insert_sequence => "MyText",
        :promoter => nil
      )
    ])
  end

  it "renders a list of donor_constructs" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Vender Product Identifier".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
