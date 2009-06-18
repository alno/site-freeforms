ActiveRecord::Base.instance_eval do
  
  def acts_as_accessible_by_key
    include ::Ext::AccessibleByKey
  end
  
end