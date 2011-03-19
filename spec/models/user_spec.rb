require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do

  specify "should not create a new instance without password" do
    User.make( :password => nil ).should have(2).error_on(:password)
  end

  specify "should not create a new instance with invalid email" do
    User.make( :email => 'fe&r3d((' ).should have(1).error_on(:email)
  end

  it { should have_many :forms }
  it { should have_many :messages }

  it { should validate_uniqueness_of :access_key }

  context "new" do

    before(:all) do
      @u = User.make!
    end

    it { @u.should be_valid }
    it { @u.should have(1).form }
    it { @u.access_key.should_not be_nil }

  end

end

describe "Mail" do
  include ActionController::UrlWriter

  default_url_options[:host] = APP_HOST

  before(:all) do
    @user = User.make!
  end

  context "for Signup" do

    before(:all) do
      @email = UserMailer.activation_instructions(@user)
    end

    it "should be set to be delivered to the email passed in" do
      @email.should deliver_to(@user.email)
    end

    it "should contain a link to the confirmation link" do
      @email.should have_body_text(/#{account_activation_url(@user.perishable_token)}/)
    end

    it "should have the correct subject" do
      @email.should have_subject(/Account Activation Instructions/)
    end

  end

  describe "for Password Reset" do

    before(:all) do
      @email = UserMailer.password_reset_instructions(@user)
    end

    it "should be set to be delivered to the email passed in" do
      @email.should deliver_to(@user.email)
    end

    it "should contain a link to the confirmation link" do
      @email.should have_body_text(/#{account_password_url(@user.perishable_token)}/)
    end

    it "should have the correct subject" do
      @email.should have_subject(/Восстановление пароля на freeforms.ru/)
    end

  end

end
