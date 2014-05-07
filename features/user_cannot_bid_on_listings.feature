@pending
Feature: Users cannot bid on listings
  In order to switch to a sales format
  As an admin
  I don't want users to be able to bid on items

  - facility to place bids is removed

  Scenario: User does not see the option to place a bid after the listing is over
    Given this listing exists:
      | title      | starting_price | seller   |
      | zoot suits | 12.00          | Jane Doe |
    Given I am signed in
    When I go to the listing page for "zoot suits"
    Then I should not see "Bid Amount"