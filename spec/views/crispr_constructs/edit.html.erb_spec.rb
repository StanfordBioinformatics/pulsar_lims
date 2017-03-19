require 'rails_helper'

RSpec.describe "crispr_constructs/edit", type: :view do
  before(:each) do
    @crispr_construct = assign(:crispr_construct, CrisprConstruct.create!(
      :name => "MyString",
      :user => nil,
      :target => nil,
      :guide_sequence => "MyText",
      :cloning_vector => nil,
      :description => "MyText",
      :vendor => nil,
      :vendor_product_identifier => "MyString"
    ))
  end

  it "renders the edit crispr_construct form" do
    render

    assert_select "form[action=?][method=?]", crispr_construct_path(@crispr_construct), "post" do

      assert_select "input#crispr_construct_name[name=?]", "crispr_construct[name]"

      assert_select "input#crispr_construct_user_id[name=?]", "crispr_construct[user_id]"

      assert_select "input#crispr_construct_target_id[name=?]", "crispr_construct[target_id]"

      assert_select "textarea#crispr_construct_guide_sequence[name=?]", "crispr_construct[guide_sequence]"

      assert_select "input#crispr_construct_cloning_vector_id[name=?]", "crispr_construct[cloning_vector_id]"

      assert_select "textarea#crispr_construct_description[name=?]", "crispr_construct[description]"

      assert_select "input#crispr_construct_vendor_id[name=?]", "crispr_construct[vendor_id]"

      assert_select "input#crispr_construct_vendor_product_identifier[name=?]", "crispr_construct[vendor_product_identifier]"
    end
  end
end
