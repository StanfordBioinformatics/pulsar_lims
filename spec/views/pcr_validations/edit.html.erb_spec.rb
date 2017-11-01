require 'rails_helper'

RSpec.describe "pcr_validations/edit", type: :view do
  before(:each) do
    @pcr_validation = assign(:pcr_validation, PcrValidation.create!(
      :user => nil,
      :description => "MyText",
      :pcr_master_mix => nil,
      :forward_primer => "MyString",
      :reverse_primer => "MyString",
      :amplicon_size => 1,
      :annealing_temperature => 1.5,
      :extension_time => 1,
      :num_cycles => 1,
      :crispr_modification => nil,
      :success => false
    ))
  end

  it "renders the edit pcr_validation form" do
    render

    assert_select "form[action=?][method=?]", pcr_validation_path(@pcr_validation), "post" do

      assert_select "input#pcr_validation_user_id[name=?]", "pcr_validation[user_id]"

      assert_select "textarea#pcr_validation_description[name=?]", "pcr_validation[description]"

      assert_select "input#pcr_validation_pcr_master_mix_id[name=?]", "pcr_validation[pcr_master_mix_id]"

      assert_select "input#pcr_validation_forward_primer[name=?]", "pcr_validation[forward_primer]"

      assert_select "input#pcr_validation_reverse_primer[name=?]", "pcr_validation[reverse_primer]"

      assert_select "input#pcr_validation_amplicon_size[name=?]", "pcr_validation[amplicon_size]"

      assert_select "input#pcr_validation_annealing_temperature[name=?]", "pcr_validation[annealing_temperature]"

      assert_select "input#pcr_validation_extension_time[name=?]", "pcr_validation[extension_time]"

      assert_select "input#pcr_validation_num_cycles[name=?]", "pcr_validation[num_cycles]"

      assert_select "input#pcr_validation_crispr_modification_id[name=?]", "pcr_validation[crispr_modification_id]"

      assert_select "input#pcr_validation_success[name=?]", "pcr_validation[success]"
    end
  end
end
