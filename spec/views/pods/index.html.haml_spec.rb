require 'spec_helper'

describe "pods/index" do
  before(:each) do
    assign(:pods, [
      stub_model(Pod),
      stub_model(Pod)
    ])
  end

  it "renders a list of pods" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
