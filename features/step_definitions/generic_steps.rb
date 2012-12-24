When /^I go to location "([^"]*)"$/ do |location|
  visit location
end

Then /^I should be at location "([^"]*)"$/ do |location|
  article.current_path.should == location
end

Then /^I should be at root article$/ do
  steps %Q{
    Then I should be at location "/"
  }
end

Then /^I should see a success message$/ do
  article.should have_css('.notice')
end

Then /^I should see a failure message$/ do
  article.should have_css('.alert')
end

When /^I type in "([^"]*)" form:$/ do |form, table|
  within("##{form}") do
    table.hashes.each { |row| find("##{row[:param]}").set(row[:value]) }
    find('[@type=submit]').click
  end
end
