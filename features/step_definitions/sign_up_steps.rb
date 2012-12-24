When /^I go to sign up article$/ do
  steps %Q{
    When I go to location "/users/sign_up"
  }
end

When /^I try to sign out$/ do
  steps %Q{
  }
end

When /^type in email "(.*?)", password "(.*?)", password confirmation "(.*?)" and some good profile data in sign up form$/ do |email, password, password_confirmation|
  steps %Q{
    When I type in "new_user" form:
      | param                          | value                    |
      | user_email                     | #{email}                 |
      | user_password                  | #{password}              |
      | user_password_confirmation     | #{password_confirmation} |
      | user_profile_attributes_name   | Sasha                    |
      | user_profile_attributes_gender | female                   |
  }
end

When /^type in email "(.*?)", password "(.*?)", password confirmation "(.*?)" and some bad profile data in sign up form$/ do |email, password, password_confirmation|
  steps %Q{
    When I type in "new_user" form:
      | param                      | value                    |
      | user_email                 | #{email}                 |
      | user_password              | #{password}              |
      | user_password_confirmation | #{password_confirmation} |
  }
end
