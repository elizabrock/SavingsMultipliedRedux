@pending
Feature: Admin manages site pages
  In order to control the site content
  As an admin
  I want to create and edit the non-dynamic site pages

  Scenario: Create and View a new site page
    Given I am signed in as an administrator
    When I go to the admin site
    And click "Pages"
    And click "Add new"
    And I fill in "Title" with "Discounts"
    And I fill in "Url slug" with "discounts"
    And I fill in "Content" with "this is my page with a <a href='#'>link to nowhere</a>"
    And I click "Create Page"
    Then I should see a success message
    When I go to "savingsmultiplied.com/pages/discounts"
    Then I should see the page title of "Discounts"
    And I should see that the html page title is "Discounts on Savings Multiplied"
    And I should see a link "link to nowhere"

  Scenario: Logged-in-user-only pages
    Given there is a signin-required page at "pages/exclusive-discounts"
    And I am signed out
    When I go to "savingsmultiplied.com/pages/exclusive-discounts"
    Then I should be on the sign in page
    When I fill in the sign in form and submit it
    Then I should be on the "savingsmultiplied.com/pages/exclusive-discounts" page
    Then I should not see "The page could not be found."

  Scenario: Deleting a page
    Given I am signed in as an administrator
    And there is a page at "pages/special-today-only"
    When I go to "savingsmultiplied.com/pages/special-today-only"
    Then I should not see "The page could not be found."
    When I delete the page at "pages/special-today-only"
    And I go to "savingsmultiplied.com/pages/special-today-only"
    Then I should see "The page could not be found."