require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Field" do
  
  def accept(value)
    simple_matcher do |given,matcher|
      matcher.description = "accept value '#{value}'"
      matcher.failure_message = "expected #{given.inspect} to accept '#{value}'"
      matcher.negative_failure_message = "expected #{given.inspect} not to accept '#{value}'"
      given.error_for(value).nil?
    end
  end
  
  context "empty" do
    before(:all) do
      @field = Form::Field.new      
    end    
    
    it { @field.escaped_title.should be_nil }
    it { @field.escaped_default.should be_nil }
  end
    
  it { Form::Field.new(:title => '123').title.should == '123' }
  it { Form::Field.new(:default => '123').default.should == '123' }
  
  it { Form::Field.new(:title => 'Тест').escaped_title.should == HTMLEntities.encode_entities('Тест', :basic, :decimal) }
  it { Form::Field.new(:default => 'По умолчанию').escaped_default.should == HTMLEntities.encode_entities('По умолчанию', :basic, :decimal) }
    
  it { Form::TextField.new(:title => '123', :default => 'deaa').render_input(12,1).should == '<p id="mf_12_1" class="mf_text"><label for="fields[1]">123</label><span id="mfe_12_1"></span><textarea name="fields[1]">deaa</textarea></p>' }
  it { Form::TextField.new(:title => 'тест', :default => 'по умолчанию').render_input(12,1).should == '<p id="mf_12_1" class="mf_text"><label for="fields[1]">' + HTMLEntities.encode_entities('тест', :basic, :decimal) + '</label><span id="mfe_12_1"></span><textarea name="fields[1]">' + HTMLEntities.encode_entities('по умолчанию', :basic, :decimal) + '</textarea></p>' }
    
  context Form::StringField.new(:title => '123'), "string" do
    #it { should render_input( 12, 1, '<p id="mf_12_1" class="mf_string"><label for="fields[1]">123</label><input type="text" name="fields[1]" /><span id="mfe_12_1"></span></p>' ) }
    #it { should render_value( 'fdszcxd', 'fdszcxd' ) }
  end
  
  context Form::StringField.new(:title => '123', :default => 'def'), "string with default" do
    #it { should render_input( 12, 1, '<p id="mf_12_1" class="mf_string"><label for="fields[1]">123</label><input type="text" name="fields[1]" value="def" /><span id="mfe_12_1"></span></p>' ) }
  end
  
  context Form::TextField.new(:title => '1234'), "text" do    
    #it { should render_value( '123', '<pre>123</pre>' ) }    
    #it { should render_input( 13, 1, '<p id="mf_13_1" class="mf_text"><label for="fields[1]">1234</label><span id="mfe_13_1"></span><textarea name="fields[1]"></textarea></p>' ) }
    it { should accept( "tester@mail.ru" ) }
    it { should accept( "" ) }
    it { should accept( nil ) }
  end
  
  context Form::TextField.new(:required => true), "required text" do    
    it { should accept( "tester@mail.ru" ) }
    it { should_not accept( "" ) }
    it { should_not accept( nil ) }
  end
  
  context Form::EmailField.new(:title => 'qwerty'), "email" do    
    #it { should render_input( 15, 7, '<p id="mf_15_7" class="mf_email"><label for="fields[7]">qwerty</label><input type="text" name="fields[7]" /><span id="mfe_15_7"></span></p>' ) }    
    it { should accept( "tester@mail.ru" ) }
    it { should accept( "12345@dff22.com.ua" ) }
    it { should accept( "asdf11@mail.ru" ) }
    it { should_not accept( "12345@dff22.com.ua." ) }
    it { should_not accept( "12345@ru" ) }
    it { should accept( "" ) }
    it { should accept( nil ) }
  end
  
  context Form::EmailField.new(:required => true), "required email" do    
    it { should accept( "tester@mail.ru" ) }
    it { should_not accept( "12345@dff22.com.ua." ) }
    it { should_not accept( "" ) }
    it { should_not accept( nil ) }
  end
  
end

describe Form do
  
  it { should validate_uniqueness_of :access_key }
  it { should have_many :messages }

  describe "new" do
    
    before(:all) do
       @form = Form.make
    end
    
    it { @form.should be_valid }
    it { @form.should have(2).fields }
    it { @form.fields[0].title.should == I18n.t( 'form_fields.name' ) }
    it { @form.fields[1].title.should == I18n.t( 'form_fields.content' ) }
    it { @form.access_key.should_not be_nil }
    
  end
end
