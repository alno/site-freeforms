require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User.make, "New user" do
      
  it { should be_valid }    
  it { should have(1).form }
  
end  

describe User do
  
  it "should not create a new instance without password" do
    u = User.make_unsaved( :password => nil )
    u.should have(2).error_on(:password)
  end
  
  it "should not create a new instance with invalid email" do
    u = User.make_unsaved( :email => 'fe&r3d((' )
    u.should have(1).error_on(:email)
  end
  
end

describe "Mail" do
  include ActionController::UrlWriter
  
  default_url_options[:host] = APP_HOST

  before(:all) do
    @user = User.make
  end  
  
  context "for Signup" do
    
    before(:all) do
      @email = UserMailer.create_activation_instructions(@user)
    end
  
    it "should be set to be delivered to the email passed in" do
      @email.should deliver_to(@user.email)
    end
  
    it "should contain a link to the confirmation link" do
      @email.should have_text(/#{account_activation_url(@user.perishable_token)}/)
    end
  
    it "should have the correct subject" do
      @email.should have_subject(/Account Activation Instructions/)
    end
    
  end
  
  describe "for Password Reset" do
    
    before(:all) do
      @email = UserMailer.create_password_reset_instructions(@user)
    end
  
    it "should be set to be delivered to the email passed in" do
      @email.should deliver_to(@user.email)
    end
  
    it "should contain a link to the confirmation link" do
      @email.should have_text(/#{account_password_url(@user.perishable_token)}/)
    end
  
    it "should have the correct subject" do
      @email.should have_subject(/Password Reset Instructions/)
    end
    
  end

end


