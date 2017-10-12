require 'rails_helper'

RSpec.describe "data_file_types/index", type: :view do
  before(:each) do
    assign(:data_file_types, [
      DataFileType.create!(
        :user => nil,
        :name => "Name",
        :description => "MyText"
      ),
      DataFileType.create!(
        :user => nil,
        :name => "Name",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of data_file_types" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
