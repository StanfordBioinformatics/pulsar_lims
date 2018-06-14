require 'rails_helper'

RSpec.describe "chipseq_experiments/index", type: :view do
  before(:each) do
    assign(:chipseq_experiments, [
      ChipseqExperiment.create!(
        :user => nil,
        :name => "Name",
        :description => "MyText",
        :upstream_identifier => "Upstream Identifier",
        :target => nil,
        :submitter_comments => "MyText",
        :notes => "MyText"
      ),
      ChipseqExperiment.create!(
        :user => nil,
        :name => "Name",
        :description => "MyText",
        :upstream_identifier => "Upstream Identifier",
        :target => nil,
        :submitter_comments => "MyText",
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of chipseq_experiments" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Upstream Identifier".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
