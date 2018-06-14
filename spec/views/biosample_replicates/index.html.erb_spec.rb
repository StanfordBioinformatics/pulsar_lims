require 'rails_helper'

RSpec.describe "biosample_replicates/index", type: :view do
  before(:each) do
    assign(:biosample_replicates, [
      BiosampleReplicate.create!(
        :user => nil,
        :name => "Name",
        :upstream_identifier => "Upstream Identifier",
        :biological_replicate_number => 2,
        :technical_replicate_number => 3,
        :notes => "MyText"
      ),
      BiosampleReplicate.create!(
        :user => nil,
        :name => "Name",
        :upstream_identifier => "Upstream Identifier",
        :biological_replicate_number => 2,
        :technical_replicate_number => 3,
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of biosample_replicates" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Upstream Identifier".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
