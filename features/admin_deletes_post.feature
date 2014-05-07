@pending
Feature: Admin deletes a post
  In order to censor communication amongst the users
  As an admin
  I want to delete posts

  Scenario: Delete a forum topic
    Given I am signed in
    And I am a forum admin
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