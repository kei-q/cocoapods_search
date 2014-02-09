require 'spec_helper'

describe "pods/new" do
  before(:each) do
    assign(:pod, stub_model(Pod).as_new_record)
  end

  it "renders new pod form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", pods_path, "post" do
    end
  end
end
