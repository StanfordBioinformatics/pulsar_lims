require 'rails_helper'

RSpec.describe "file_references/index", type: :view do
  before(:each) do
    assign(:file_references, [
      FileReference.create!(
        :user => nil,
        :data_storage => nil,
        :file_path => "File Path",
        :fileid => "Fileid"
      ),
      FileReference.create!(
        :user => nil,
        :data_storage => nil,
        :file_path => "File Path",
        :fileid => "Fileid"
      )
    ])
  end

  it "renders a list of file_references" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "File Path".to_s, :count => 2
    assert_select "tr>td", :text => "Fileid".to_s, :count => 2
  end
end
