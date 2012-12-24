When /^I go to sign out article$/ do
  steps %Q{
    When I go to location "/users/sign_out"
  }
end

When /^I try to sign out$/ do
  steps %Q{
    When I go to sign out article
  }
end

Given /^I have signed out$/ do
  steps %Q{
    Given I go to sign out article
    And I should be a Guest
  }
end
