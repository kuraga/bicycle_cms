Given /^I am a Guest$/ do
  steps %Q{
    Given I have signed out
  }
end

Then /^I should be a Guest$/ do
#XYZ  pending
end

Given /^I am a User$/ do
  steps %Q{
    Given I have signed in with email "email@example.com" and password "password"
  }
end

Then /^I should be a User with email "([^"]*)"$/ do |email|
#XYZ  pending
p current_session.current_user
end

Then /^I should have an ability to sign in with email "(.*?)" and password "(.*?)"$/ do |arg1, arg2|
#XYZ  pending
end

Then /^a User with email "(.*?)" should be created$/ do |email|
#XYZ  pending
end

Then /^a User should not be created$/ do
#XYZ  pending
end
