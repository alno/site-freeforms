require 'spec_helper'

describe "forms/code.js" do

  before do
    @form = Form.make!

    render
  end

  it "should include fields" do
    rendered.should include 'name="fields[0]"'
    rendered.should include 'name="fields[1]"'
  end

end

describe "forms/code.html" do

  before do
    @form = Form.make!

    render
  end

  it "should include fields" do
    rendered.should include @form.title
    rendered.should include @form.code
  end

end

describe "forms/new.html" do

  context "with basic form" do

    before do
      @form = Form.make

      render
    end

    it "should include form title" do
      rendered.should include @form.title
    end

    it "should include form submit title" do
      rendered.should include @form.submit_title
    end

  end

  context "with form having empty title" do

    before do
      @form = Form.make( :title => '' )

      render
    end

    it "should include form submit title" do
      rendered.should include @form.submit_title
    end

  end

  context "with form having empty submit title" do

    before do
      @form = Form.make( :submit_title => '' )

      render
    end

    it "should include form title" do
      rendered.should include @form.title
    end

  end

end
