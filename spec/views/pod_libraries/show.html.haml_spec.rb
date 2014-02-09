require 'spec_helper'

describe "pod_libraries/show" do
  before(:each) do
    @pod_library = assign(:pod_library, stub_model(PodLibrary))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
