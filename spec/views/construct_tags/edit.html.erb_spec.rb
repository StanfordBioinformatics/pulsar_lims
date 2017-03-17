require 'rails_helper'

RSpec.describe "construct_tags/edit", type: :view do
  before(:each) do
    @construct_tag = assign(:construct_tag, ConstructTag.create!(
      :user => nil,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit construct_tag form" do
    render

    assert_select "form[action=?][method=?]", construct_tag_path(@construct_tag), "post" do

      assert_select "input#construct_tag_user_id[name=?]", "construct_tag[user_id]"

      assert_select "input#construct_tag_name[name=?]", "construct_tag[name]"

      assert_select "textarea#construct_tag_description[name=?]", "construct_tag[description]"
    end
  end
end
