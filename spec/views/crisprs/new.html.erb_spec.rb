require 'rails_helper'

RSpec.describe "crisprs/new", type: :view do
  before(:each) do
    assign(:crispr, Crispr.new(
      :name => "MyString",
      :user => nil,
      :crispr_construct => nil,
      :donor_construct => nil,
      :biosample => nil
    ))
  end

  it "renders new crispr form" do
    render

    assert_select "form[action=?][method=?]", crisprs_path, "post" do

      assert_select "input#crispr_name[name=?]", "crispr[name]"

      assert_select "input#crispr_user_id[name=?]", "crispr[user_id]"

      assert_select "input#crispr_crispr_construct_id[name=?]", "crispr[crispr_construct_id]"

      assert_select "input#crispr_donor_construct_id[name=?]", "crispr[donor_construct_id]"

      assert_select "input#crispr_biosample_id[name=?]", "crispr[biosample_id]"
    end
  end
end
