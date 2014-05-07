@pending
Feature: User creates forum topic
  In order to communicate with other users
  As an user
  I want to create forum topics

  Scenario: Create and View a forum topic
    Given I am signed in
    And there is a forum "Off Topic"
    And I am on the home page
    When I click "Message Board"
    And I click "Off Topic"
    And I click "New topic"
    And I fill in "Subject" with "Something about twins"
    And I fill in "Text" with "They look so similar"
    And I click "Create Topic"
    Then I should see "Something about twins"
    Then I should see "They look so similar"
    And I should see "This topic has been created."

  Scenario: Reply to forum topic
    Given I am signed in
    And there is a forum "Off Topic"
    And I am on the home page
    When I click "Message Board"
    And I click "Off Topic"
    And I click "New topic"
    And I fill in "Subject" with "Something about twins"
    And I fill in "Text" with "They look so similar"
    And I click "Create Topic"
    And I click "Reply"
    And I fill in "Text" with "No they don't"
    And I click "Reply"
    Then I should see "They look so similar"
    And I should see "No they don't"

  Scenario: not logged in, create topic attempt
    Given I am signed out
    And there is a forum "Off Topic"
    And I am on the home page
    When I click "Message Board"
    And I click "Off Topic"
    And I click "New topic"
    Then I should see "Sign in"
    And I should not see "Creating a new topic"
    When I fill in the sign in form and submit it
    Then I should see "Creating a new topic"

  Scenario: Reply to forum topic when not signed in
    Given I am signed out
    And there is a forum "Off Topic"
    And there is a topic "Something about twins"
    And I am on the home page
    When I click "Message Board"
    And I click "Off Topic"
    And I click "Something about twins"
    And I click "Reply"
    Then I should not see "Post reply"
    When I fill in the sign in form and submit it
    Then I should see "Post reply"