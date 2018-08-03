require 'rails_helper'

RSpec.describe "immunoblots/index", type: :view do
  before(:each) do
    assign(:immunoblots, [
      Immunoblot.create!(
        :user => nil,
        :agarose_gel => nil,
        :submitter_comments => "MyText",
        :notes => "MyText"
      ),
      Immunoblot.create!(
        :user => nil,
        :agarose_gel => nil,
        :submitter_comments => "MyText",
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of immunoblots" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
