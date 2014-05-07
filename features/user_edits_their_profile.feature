@pending
Feature: User Edits Their Profile
  In order to control the information that is displayed about me
  As a signed in user
  I want to edit my profile

  Background:
    Given there is a child configuration of "quads" "mmff"

  Scenario: Editing My Profile
    Given I am signed in as "Jane Smith"
    And there is a "mother" relationship
    When I go to the homepage
    And I click "Jane S."
    When I click "Edit my profile"
    And I fill in "Rachel" for "First name"
    And I fill in "Folger" for "Last name"
    And I select "mother" from "I am the"
    And I select "quads - mmff" from "darling children"
    And I fill in "SAHM from Indianapolis" for "Bio"
    And I click "Update My Profile"
    Then I should be on the home page
    When I click "Rachel F."
    Then I should see the heading "Rachel F."
    And I should see "Rachel F."
    And I should see "mother to 4"
    And I should see 2 boys
    And I should see 2 girls
    And I should see "SAHM from Indianapolis"

  Scenario: Editing My Profile- Adding a photo
    Given I am signed in as "Jane Smith"
    When I go to the homepage
    And I click "Jane S."
    Then I should see the default user profile photo
    When I click "Edit my profile"
    And I attach "profile_image" "png" to the "user"
    And I fill in "SAHM from Indianapolis" for "Bio"
    And I fill in "First name" with "Rachel"
    And I fill in "Last name" with "Folger"
    And I click "Update My Profile"
    Then I should be on the home page
    When I click "Rachel F."
    Then I should see the heading "Rachel F."
    And I should see "Rachel F."
    And I should see the uploaded user profile photo

  Scenario: Attempting to edit someone else's profile
    Given I am signed in as "Jane Smith"
    And there is a user "Bob Sagen"
    When I go to the profile page for "Bob Sagen"
    Then I should not see "Edit my profile"