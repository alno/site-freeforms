require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Form do
  
  it { should validate_uniqueness_of :access_key }
  it { should validate_presence_of :submit_title }
  it { should validate_presence_of :user }
  
  it { should have_many :messages }

  describe "generated" do
    
    before(:all) do
      @form = Form.make
    end
    
    it { @form.should be_valid }
    it { @form.access_key.should_not be_nil }
    
  end
  
  describe "default" do
    
    before(:all) do
      @user = User.make
      @form = @user.forms.create
    end
    
    it { @form.should be_valid }
    it { @form.should have(2).fields }
    it { @form.fields[0].title.should == I18n.t( 'form_fields.name' ) }
    it { @form.fields[1].title.should == I18n.t( 'form_fields.content' ) }
    it { @form.access_key.should_not be_nil }
    
  end
  
end
