require 'rails_helper'

RSpec.describe "chromosomes/show", type: :view do
  before(:each) do
    @chromosome = assign(:chromosome, Chromosome.create!(
      :name => "Name",
      :user => nil,
      :reference_genome => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
