require 'rails_helper'

RSpec.describe "cloning_vectors/edit", type: :view do
  before(:each) do
    @cloning_vector = assign(:cloning_vector, CloningVector.create!(
      :user => nil,
      :name => "MyString",
      :description => "MyText",
      :url => "MyString"
    ))
  end

  it "renders the edit cloning_vector form" do
    render

    assert_select "form[action=?][method=?]", cloning_vector_path(@cloning_vector), "post" do

      assert_select "input#cloning_vector_user_id[name=?]", "cloning_vector[user_id]"

      assert_select "input#cloning_vector_name[name=?]", "cloning_vector[name]"

      assert_select "textarea#cloning_vector_description[name=?]", "cloning_vector[description]"

      assert_select "input#cloning_vector_url[name=?]", "cloning_vector[url]"
    end
  end
end
