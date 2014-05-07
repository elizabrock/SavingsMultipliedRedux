@pending @javascript
Feature: Users can remove listings
  In order to remove items that are damaged or sold elsewhere
  As a user
  I want to remove my listing

  - clicking "remove listing" archives the listing (visible only on the back end)

  Background:
    Given I am signed in as "Jane Eyre"
    And this listing exists:
      | title      | seller    |
      | Sweet Bibs | Jane Eyre |

  Scenario: Confirming delete
    When I go to the listing page for "Sweet Bibs"
    Then I should see "Remove Listing"
    When I click "Remove Listing"
    Then I should see "Why are you removing this listing?"
    When I choose "Will try again later"
    When I press "Confirm"
    Then I should see a notice that "Your listing for Sweet Bibs has been removed."

  Scenario: Canceling delete
    When I go to the listing page for "Sweet Bibs"
    Then I should see "Remove Listing"
    When I click "Remove Listing"
    When I choose "Will try again later"
    And I press "Cancel"
    Then I should not see "Your listing for Sweet Bibs has been removed."
    When I go to the listing page for "Sweet Bibs"
    Then I should not see "This listing is no longer available."

  Scenario: Deleted listings are viewable to admins
    When I go to the listing page for "Sweet Bibs"
    And I click "Remove Listing"
    When I choose "Will try again later"
    And I press "Confirm"
    Then I should see the following listing in the database:
      | title | Sweet Bibs |
      | state | deleted    |

  Scenario: Deleted listings aren't shown on the listings page
    When I go to the listings page
    Then I should see "Sweet Bibs"
    When I go to the listing page for "Sweet Bibs"
    And I click "Remove Listing"
    When I choose "Will try again later"
    And I press "Confirm"
    And I go to the listings page
    Then I should not see "Sweet Bibs"

  Scenario: Deleted listings aren't shown on the user's page
    When I go to the listings page
    Then I should see "Sweet Bibs"
    When I go to the listing page for "Sweet Bibs"
    And I click "Remove Listing"
    When I choose "Will try again later"
    And I press "Confirm"
    When I go to the profile page for "Jane Eyre"
    Then I should not see "Sweet Bibs"

  Scenario: Deletion reason is required
    When I go to the listings page
    Then I should see "Sweet Bibs"
    When I go to the listing page for "Sweet Bibs"
    And I click "Remove Listing"
    Then I should see the following:
      | Keeping item(s)        |
      | Sold offline/elsewhere |
      | Will try again later   |
      | Other                  |
    And I press "Confirm"
    Then I should see "Please select your reason"
    When I choose "Will try again later"
    And I press "Confirm"
    Then I should see "Your listing for Sweet Bibs has been removed."
    And I should see the following listing in the database:
      | title           | Sweet Bibs           |
      | state           | deleted              |
      | deletion_reason | Will try again later |