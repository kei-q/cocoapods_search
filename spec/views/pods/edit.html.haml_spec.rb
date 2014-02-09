require 'spec_helper'

describe "pods/edit" do
  before(:each) do
    @pod = assign(:pod, stub_model(Pod))
  end

  it "renders the edit pod form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", pod_path(@pod), "post" do
    end
  end
end
