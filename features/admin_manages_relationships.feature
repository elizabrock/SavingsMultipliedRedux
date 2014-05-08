@wip @pending
# This is merely a sanity check for the active admin setup
Feature: Admin manages relationships, categories, etc.
  Feature: Admin creates pattern

  As an admin
  In order to sell a pattern
  I want to create a listing for that pattern

  Scenario: Creating Relationships
    Given that I am signed in as an administrator
    When I go to the admin dashboard page
    And I press "Relationships"
    And I press "New Relationship"
    And I fill in "Mother" for "Name"
    And I press "Create Relationships"
    Then I should see "Relationship was successfully created."
    When I click "Relationships"
    And I should see "Mother"
