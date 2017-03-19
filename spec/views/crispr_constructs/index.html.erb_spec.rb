require 'rails_helper'

RSpec.describe "crispr_constructs/index", type: :view do
  before(:each) do
    assign(:crispr_constructs, [
      CrisprConstruct.create!(
        :name => "Name",
        :user => nil,
        :target => nil,
        :guide_sequence => "MyText",
        :cloning_vector => nil,
        :description => "MyText",
        :vendor => nil,
        :vendor_product_identifier => "Vendor Product Identifier"
      ),
      CrisprConstruct.create!(
        :name => "Name",
        :user => nil,
        :target => nil,
        :guide_sequence => "MyText",
        :cloning_vector => nil,
        :description => "MyText",
        :vendor => nil,
        :vendor_product_identifier => "Vendor Product Identifier"
      )
    ])
  end

  it "renders a list of crispr_constructs" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Vendor Product Identifier".to_s, :count => 2
  end
end
