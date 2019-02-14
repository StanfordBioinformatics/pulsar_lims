require 'rails_helper'

RSpec.describe "atacseqs/index", type: :view do
  before(:each) do
    assign(:atacseqs, [
      Atacseq.create!(
        :user => nil,
        :name => "Name",
        :description => "MyText",
        :submitter_comments => "MyText",
        :notes => "MyText"
      ),
      Atacseq.create!(
        :user => nil,
        :name => "Name",
        :description => "MyText",
        :submitter_comments => "MyText",
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of atacseqs" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
