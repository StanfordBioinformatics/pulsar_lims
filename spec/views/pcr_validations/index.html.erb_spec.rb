require 'rails_helper'

RSpec.describe "pcr_validations/index", type: :view do
  before(:each) do
    assign(:pcr_validations, [
      PcrValidation.create!(
        :user => nil,
        :description => "MyText",
        :pcr_master_mix => nil,
        :forward_primer => "Forward Primer",
        :reverse_primer => "Reverse Primer",
        :amplicon_size => 2,
        :annealing_temperature => 3.5,
        :extension_time => 4,
        :num_cycles => 5,
        :crispr_modification => nil,
        :success => false
      ),
      PcrValidation.create!(
        :user => nil,
        :description => "MyText",
        :pcr_master_mix => nil,
        :forward_primer => "Forward Primer",
        :reverse_primer => "Reverse Primer",
        :amplicon_size => 2,
        :annealing_temperature => 3.5,
        :extension_time => 4,
        :num_cycles => 5,
        :crispr_modification => nil,
        :success => false
      )
    ])
  end

  it "renders a list of pcr_validations" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Forward Primer".to_s, :count => 2
    assert_select "tr>td", :text => "Reverse Primer".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.5.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
