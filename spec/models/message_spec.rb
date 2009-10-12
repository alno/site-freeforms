require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Message do
  
  before :all do   
    @f = Form.make( :fields => [ 
      Form::EmailField.new( :title => I18n.t( 'form_fields.email' ), :required => true ),
      Form::StringField.new( :title => I18n.t( 'form_fields.title' ) ), 
      Form::TextField.new( :title => I18n.t( 'form_fields.content' ) ) 
    ])
  end
  
  context "new" do
    before :all do
      @m = Message.make( :data => [Sham.email, Sham.title, Sham.body], :form => @f )
    end
    
    it { @m.should be_valid }
    it { @m.form.should_not be_nil }
    it { @m.data.size.should == @m.form.fields.size }
    it { @m.access_key.should_not be_nil }
  end
  
  context "with no email" do
    before :all do
      @m = Message.make_unsaved( :data => [nil, Sham.title, Sham.body], :form => @f )
    end
    
    it { @m.should_not be_valid }
    it { @m.should have(1).error_on(0) }
    it { @m.should have(0).errors_on(1) }
    it { @m.should have(0).errors_on(2) }
  end
  
  context "with ivalid email" do
    before :all do
      @m = Message.make_unsaved( :data => ['123@111', Sham.title, Sham.body], :form => @f )
    end
    
    it { @m.should_not be_valid }
    it { @m.should have(1).error_on(0) }
    it { @m.should have(0).errors_on(1) }
    it { @m.should have(0).errors_on(2) }
  end  
    
  specify { Message.make_unsaved( :data => [Sham.email, nil, Sham.body], :form => @f ).should be_valid }

end
