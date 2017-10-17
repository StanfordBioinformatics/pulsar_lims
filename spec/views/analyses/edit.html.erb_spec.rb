require 'rails_helper'

RSpec.describe "analyses/edit", type: :view do
  before(:each) do
    @analysis = assign(:analysis, Analysis.create!(
      :user => nil,
      :description => "MyText"
    ))
  end

  it "renders the edit analysis form" do
    render

    assert_select "form[action=?][method=?]", analysis_path(@analysis), "post" do

      assert_select "input#analysis_user_id[name=?]", "analysis[user_id]"

      assert_select "textarea#analysis_description[name=?]", "analysis[description]"
    end
  end
end
