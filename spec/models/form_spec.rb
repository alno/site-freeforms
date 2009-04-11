require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "Form Fields" do
  
  describe "Empty field" do
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
    
  it { Form::StringField.new.render_value('123').should == '123' }
  it { Form::TextField.new.render_value('123').should == '<pre>123</pre>' }
  
  it { Form::StringField.new(:title => '123').render_input(12,1).should == '<p id="mf_12_1"><label for="fields[1]">123</label><input type="text" name="fields[1]" /></p>' }
  it { Form::StringField.new(:title => '123', :default => 'def').render_input(12,1).should == '<p id="mf_12_1"><label for="fields[1]">123</label><input type="text" name="fields[1]" value="def" /></p>' }
  
  it { Form::TextField.new(:title => '1234').render_input(12,1).should == '<p id="mf_12_1"><label for="fields[1]">1234</label><textarea name="fields[1]"></textarea></p>' }
  it { Form::TextField.new(:title => '123', :default => 'deaa').render_input(12,1).should == '<p id="mf_12_1"><label for="fields[1]">123</label><textarea name="fields[1]">deaa</textarea></p>' }
  it { Form::TextField.new(:title => 'тест', :default => 'по умолчанию').render_input(12,1).should == '<p id="mf_12_1"><label for="fields[1]">' + HTMLEntities.encode_entities('тест', :basic, :decimal) + '</label><textarea name="fields[1]">' + HTMLEntities.encode_entities('по умолчанию', :basic, :decimal) + '</textarea></p>' }
  
end

describe Form.make, "A new form" do
        
  it { should be_valid }
  it { should have(2).fields }
 # it { @field.fields[0].title.should == I18n.t( 'form_fields.title' ) }
 # it { @field.fields[1].title.should == I18n.t( 'form_fields.content' ) }
  
end
