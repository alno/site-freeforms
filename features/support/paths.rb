module NavigationHelpers
  def path_to(page_name)
    case page_name
    
    when /the homepage/
      root_path
    when /the new user page/
      new_user_path
    when /the about page/
      about_path
    when /the register page/
      register_path
    when /the account page/
      account_path
    when /the edit account page/
      edit_account_path
    
    # Add more page name => path mappings here
    
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in features/support/paths.rb"
    end
  end
end

World( NavigationHelpers )
