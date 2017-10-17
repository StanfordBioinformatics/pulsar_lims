require 'rails_helper'

RSpec.describe "analyses/index", type: :view do
  before(:each) do
    assign(:analyses, [
      Analysis.create!(
        :user => nil,
        :description => "MyText"
      ),
      Analysis.create!(
        :user => nil,
        :description => "MyText"
      )
    ])
  end

  it "renders a list of analyses" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
