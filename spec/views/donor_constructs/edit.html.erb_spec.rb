require 'rails_helper'

RSpec.describe "donor_constructs/edit", type: :view do
  before(:each) do
    @donor_construct = assign(:donor_construct, DonorConstruct.create!(
      :name => "MyString",
      :user => nil,
      :cloning_vector => nil,
      :vender => nil,
      :vender_product_identifier => "MyString",
      :target => nil,
      :description => "MyText",
      :insert_sequence => "MyText",
      :promoter => nil
    ))
  end

  it "renders the edit donor_construct form" do
    render

    assert_select "form[action=?][method=?]", donor_construct_path(@donor_construct), "post" do

      assert_select "input#donor_construct_name[name=?]", "donor_construct[name]"

      assert_select "input#donor_construct_user_id[name=?]", "donor_construct[user_id]"

      assert_select "input#donor_construct_cloning_vector_id[name=?]", "donor_construct[cloning_vector_id]"

      assert_select "input#donor_construct_vender_id[name=?]", "donor_construct[vender_id]"

      assert_select "input#donor_construct_vender_product_identifier[name=?]", "donor_construct[vender_product_identifier]"

      assert_select "input#donor_construct_target_id[name=?]", "donor_construct[target_id]"

      assert_select "textarea#donor_construct_description[name=?]", "donor_construct[description]"

      assert_select "textarea#donor_construct_insert_sequence[name=?]", "donor_construct[insert_sequence]"

      assert_select "input#donor_construct_promoter_id[name=?]", "donor_construct[promoter_id]"
    end
  end
end
