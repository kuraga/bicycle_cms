Feature: Sign out

  Scenario: User can sign out
    Given I am a User
    When I go to sign out article
    Then I should be a Guest
    And I should see a success message

  Scenario: Guest can sign out
    Given I am a Guest
    When I go to sign out article
    Then I should be a Guest
