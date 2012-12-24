When /^I go to sign in article$/ do
  steps %Q{
    When I go to location "/users/sign_in"
  }
end

When /^I type in email "([^"]*)" and password "([^"]*)" in sign in form$/ do |email, password|
  steps %Q{
    When I type in "new_user" form:
      | param         | value       |
      | user_email    | #{email}    |
      | user_password | #{password} |
  }
end

Then /^I should be at sign in article$/ do
  steps %Q{
    Then I should be at location "/users/sign_in"
  }
end

When /^I try to sign in with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  steps %Q{
    When I go to sign in article
    And I type in email "#{email}" and password "#{password}" in sign in form
  }
end

Given /^I have signed in with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  steps %Q{
    Given I am a Guest
    And I try to sign in with email "#{email}" and password "#{password}"
    And I should be a User with email "#{email}"
  }
end

Given /^I should have a ability to sign in with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  steps %Q{
    Given I try to sign in with email "#{email}" and password "#{password}"
    Then I should be a User with email "#{email}"
  }
end
