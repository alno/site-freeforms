require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "users/show.html" do
  before do
    assigns[:user] = @user = User.make_unsaved

    render 'users/show.html'
  end

  it "should contain user email" do
    response.should have_text(/#{Regexp.quote(@user.email)}/)
  end
end