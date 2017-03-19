require 'rails_helper'

RSpec.describe "crisprs/edit", type: :view do
  before(:each) do
    @crispr = assign(:crispr, Crispr.create!(
      :name => "MyString",
      :user => nil,
      :crispr_construct => nil,
      :donor_construct => nil,
      :biosample => nil
    ))
  end

  it "renders the edit crispr form" do
    render

    assert_select "form[action=?][method=?]", crispr_path(@crispr), "post" do

      assert_select "input#crispr_name[name=?]", "crispr[name]"

      assert_select "input#crispr_user_id[name=?]", "crispr[user_id]"

      assert_select "input#crispr_crispr_construct_id[name=?]", "crispr[crispr_construct_id]"

      assert_select "input#crispr_donor_construct_id[name=?]", "crispr[donor_construct_id]"

      assert_select "input#crispr_biosample_id[name=?]", "crispr[biosample_id]"
    end
  end
end
