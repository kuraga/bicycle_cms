Feature: Sign in

  Scenario Outline: Guest signs in with good authentication data
    Given I am a Guest
    And I go to sign in article
    When I type in email "<email>" and password "<password>" in sign in form
    Then I should be a User with email "<email>"
    And I should see a success message
    Examples:
      | email             | password |
      | email@example.com | password |

  Scenario Outline: Guest can't sign in with bad authentication data
    Given I am a Guest
    And I go to sign in article
    When I type in email "<email>" and password "<password>" in sign in form
    Then I should be a Guest
    And I should be at sign in article
    And I should see a failure message
    Examples:
      | user_email            | password     |
      | bad_email@example.com | password     |
      | email@example.com     | bad_password |
      |                       |              |
      |                       | password     |
      | email@example.com     |              |

  Scenario Outline: User can't sign in with any authentication data
    Given I am a User
    And I go to sign in article
    Then I should be at root article
    And I should see a failure message
