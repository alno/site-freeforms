require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "root/about.html" do
  before do
    render 'root/about.html'
  end

  it "should include link to root" do
    response.should have_text(/#{root_path}/)
  end
end

describe "root/index.html" do
  before do
    Authlogic::Session::Base.controller = RootController.new
    
    assigns[:user] = @user = User.new
    assigns[:user_session] = @user_session = UserSession.new

    render 'root/index.html'
  end

  it "should include tabs" do
    response.should have_text(/Войти/)
    response.should have_text(/Зарегистрироваться/)
    response.should have_text(/Восстановить пароль/)
  end
end