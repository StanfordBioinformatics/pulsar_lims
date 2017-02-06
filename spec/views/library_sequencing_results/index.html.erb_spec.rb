require 'rails_helper'

RSpec.describe "library_sequencing_results/index", type: :view do
  before(:each) do
    assign(:library_sequencing_results, [
      LibrarySequencingResult.create!(
        :name => "Name",
        :sequencing_result => nil,
        :library => nil,
        :comment => "MyText",
        :read1_uri => "Read1 Uri",
        :read2_uri => "Read2 Uri",
        :read1_count => 2,
        :read2_count => 3
      ),
      LibrarySequencingResult.create!(
        :name => "Name",
        :sequencing_result => nil,
        :library => nil,
        :comment => "MyText",
        :read1_uri => "Read1 Uri",
        :read2_uri => "Read2 Uri",
        :read1_count => 2,
        :read2_count => 3
      )
    ])
  end

  it "renders a list of library_sequencing_results" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Read1 Uri".to_s, :count => 2
    assert_select "tr>td", :text => "Read2 Uri".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
