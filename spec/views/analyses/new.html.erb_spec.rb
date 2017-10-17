require 'rails_helper'

RSpec.describe "analyses/new", type: :view do
  before(:each) do
    assign(:analysis, Analysis.new(
      :user => nil,
      :description => "MyText"
    ))
  end

  it "renders new analysis form" do
    render

    assert_select "form[action=?][method=?]", analyses_path, "post" do

      assert_select "input#analysis_user_id[name=?]", "analysis[user_id]"

      assert_select "textarea#analysis_description[name=?]", "analysis[description]"
    end
  end
end
