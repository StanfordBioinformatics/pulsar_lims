require 'rails_helper'

RSpec.describe "sequencing_library_prep_kits/index", type: :view do
  before(:each) do
    assign(:sequencing_library_prep_kits, [
      SequencingLibraryPrepKit.create!(
        :user => nil,
        :name => "Name",
        :vendor => nil,
        :description => "MyText"
      ),
      SequencingLibraryPrepKit.create!(
        :user => nil,
        :name => "Name",
        :vendor => nil,
        :description => "MyText"
      )
    ])
  end

  it "renders a list of sequencing_library_prep_kits" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
