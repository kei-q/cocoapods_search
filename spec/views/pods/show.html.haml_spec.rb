require 'spec_helper'

describe "pods/show" do
  before(:each) do
    @pod = assign(:pod, stub_model(Pod))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
