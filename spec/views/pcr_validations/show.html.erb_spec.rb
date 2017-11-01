require 'rails_helper'

RSpec.describe "pcr_validations/show", type: :view do
  before(:each) do
    @pcr_validation = assign(:pcr_validation, PcrValidation.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Forward Primer/)
    expect(rendered).to match(/Reverse Primer/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
  end
end
