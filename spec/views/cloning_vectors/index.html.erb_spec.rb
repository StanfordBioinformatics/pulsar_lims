require 'rails_helper'

RSpec.describe "cloning_vectors/index", type: :view do
  before(:each) do
    assign(:cloning_vectors, [
      CloningVector.create!(
        :user => nil,
        :name => "Name",
        :description => "MyText",
        :url => "Url"
      ),
      CloningVector.create!(
        :user => nil,
        :name => "Name",
        :description => "MyText",
        :url => "Url"
      )
    ])
  end

  it "renders a list of cloning_vectors" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
