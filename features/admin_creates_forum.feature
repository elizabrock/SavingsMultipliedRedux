@pending
Feature: Admin creates a forum
  In order to facilitate communication amongst the users
  As an admin
  I want to create a forum

  Scenario: Create and View a forum
    Given I am signed in
    And I am a forum admin
    And I am on the home page
    When I click "Message Board"
    And I click "Admin Area"
    And I click "Forums"
    And I click "New Forum"
    And I fill in "Title" with "Babies"
    And I fill in "Description" with "Baby Talk"
    And I click "Create Forum"
    Then I should be on the admin forum list page
    And I should see "Babies"
    And I should see "Baby Talk"

  Scenario: Non-admin can't create forum
    Given I am signed in
    When I go to the admin forum list page
    Then I should not see "New Forum"