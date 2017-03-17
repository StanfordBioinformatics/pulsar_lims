require 'rails_helper'

RSpec.describe "construct_tags/new", type: :view do
  before(:each) do
    assign(:construct_tag, ConstructTag.new(
      :user => nil,
      :name => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new construct_tag form" do
    render

    assert_select "form[action=?][method=?]", construct_tags_path, "post" do

      assert_select "input#construct_tag_user_id[name=?]", "construct_tag[user_id]"

      assert_select "input#construct_tag_name[name=?]", "construct_tag[name]"

      assert_select "textarea#construct_tag_description[name=?]", "construct_tag[description]"
    end
  end
end
