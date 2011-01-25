require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "accounts/show.html" do
  before do
    assigns[:user] = @user = User.make

    render
  end

  it "should contain user email" do
    rendered.should include @user.email
  end
end
