class WikiPagesController < ApplicationController
  
  acts_as_wiki_pages_controller
  
  def edit_allowed?
    current_user
  end
  
end