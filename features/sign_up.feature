Feature: Sign up

  Scenario Outline: Guest can sign up
    Given I am a Guest
    When I go to sign up article
    And type in email "<email>", password "<password>", password confirmation "<password_confirmation>" and some good profile data in sign up form
    Then a User with email "<email>" should be created
    And I should have an ability to sign in with email "<email>" and password "<password>"
    Examples:
      | email              | password | password_confirmation |
      | email1@example.com | apple    | apple                 |

  Scenario Outline: Guest can't sign up unless type in good profile data
    Given I am a Guest
    When I go to sign up article
    And type in email "<email>", password "<password>", password confirmation "<password_confirmation>" and some good profile data in sign up form
    Then a User should not be created
    And I should see a failure message
    Examples:
      | email              | password | password_confirmation |
      | email1@example     | apple    | apple                 |
      | bad_email          | apple    | applebla              |
      | bad_email          | apple    | applebla              |
      |                    | apple    | apple                 |
      | email1@example     |          | apple                 |
      | email1@example     | apple    |                       |
      |                    |          |                       |

  Scenario Outline: Guest can't sign up unless type in good profile data
    Given I am a Guest
    When I go to sign up article
    And type in email "<email>", password "<password>", password confirmation "<password_confirmation>" and some bad profile data in sign up form
    Then a User should not be created
    And I should see a failure message
    Examples:
      | email              | password | password_confirmation |
      | email1@example.com | apple    | apple                 |
