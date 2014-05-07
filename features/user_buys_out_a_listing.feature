@pending
Feature: User buys out an listing
  In order to purchase an item without waiting for an listing
  As a logged in user viewing an listing with a buy now price
  I want to use buy now to buy the listing now

  - User presses "buy now" from an listing page
  - user is asked to confirm the "buy now" on a confirmation page
  - Immediately directed into the paypal flow
  - Listing is no longer eligible for bids
  - Listing becomes ineligible for Buy Now once the highest bid is over buy it now price.

  Background:
    Given I am signed in
    And this listing exists:
      | title      | starting_price | buy_now_price |
      | zoot suits | 5.00           | 13.00         |

  Scenario: Success
    When I go to the listing page for "zoot suits"
    Then I should see "Buy Now"
    When I press "Buy Now"
    Then I should see the heading "Confirm Buy Now"
    When I press "Confirm Buy Now"
    Then I should be on paypal
    When I go to the listing page for "zoot suits"
    Then I should not see "Buy Now"
    And I should not see "Place a Bid"
    And I should see "Sold On"

  Scenario: Buy Now when not logged in
    Given I am not signed in
    When I go to the listing page for "zoot suits"
    Then I should see "Buy Now"
    When I press "Buy Now"
    # This works in reality, but not in the tests
    Then I should be on the signin page
    When I fill in the sign in form and submit it
    Then I should see the heading "Confirm Buy Now"

  Scenario: Not Confirming Buy Now
    When I go to the listing page for "zoot suits"
    Then I should see "Buy Now"
    When I press "Buy Now"
    Then I should see the heading "Confirm Buy Now"
    When I click "cancel"
    Then I should be on the listing page for "zoot suits"
    And I should see "Buy Now"
