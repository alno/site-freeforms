class FormsController < ApplicationController
  
  layout 'default', :except => [ :code ]
    
  before_filter :require_user, :except => [ :code ]
  
  cache_sweeper FormCodeSweeper, :only => [ :update, :destroy ]
  
  caches_page :code
  
  def code
    @form = Form.find(params[:id])
  end
  
  def index    
  end
  
  def show
    @form = current_user.forms.find(params[:id])
  end
  
  def edit
    @form = current_user.forms.find(params[:id])
  end
  
  def update
    @form = current_user.forms.find(params[:id])
    @form.title = params[:form][:title]
    @form.description = params[:form][:description]
    @form.fields = []
    
    params[:form][:fields].each do |k,f|
      @form.fields << Form::Field.create( f[:type], :title => f[:title], :default => f[:default], :disabled => (f[:enabled].to_i != 1) )
    end    
    
    if @form.save
      redirect_to form_path( @form )
    else
      render :action => :edit
    end
  end

end
