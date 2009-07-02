Given /^the following users:$/ do |users|
  User.create!(users.hashes)
end

Given /^I am logged in as "([^\"]*)"$/ do |email|
  @current_user = User.create!(
    :email => email,
    :password => 'generic',
    :password_confirmation => 'generic',
    :activated_at => Time.now
  )

  visit '/'
  fill_in("session[email]", :with => @current_user.email) 
  fill_in("session[password]", :with => @current_user.password) 
  click_button("Войти")
  
  response.body.should =~ /вошли/m
end

Given /^I am registered in as "([^\"]*)"$/ do |email|
  @current_user = User.create!(
    :email => email,
    :password => 'generic',
    :password_confirmation => 'generic',
    :activated_at => Time.now
  )
end

When /^I delete the (\d+)(?:st|nd|rd|th) user$/ do |pos|
  visit users_url
  within("table > tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should be able to login as "([^\"]*)" with "([^\"]*)"$/ do |email, password|
  visit '/logout'
  fill_in("session[email]", :with => email) 
  fill_in("session[password]", :with => password) 
  click_button("Войти")
  
  response.body.should =~ /вошли/m
end

Then /^I should see the following users:$/ do |users|
  users.rows.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      response.should have_selector("table > tr:nth-child(#{i+2}) > td:nth-child(#{j+1})") { |td|
        td.inner_text.should == cell
      }
    end
  end
end
