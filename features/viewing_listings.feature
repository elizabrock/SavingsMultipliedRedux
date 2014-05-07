@pending
Feature: User views an listing page
  In order to inspect an item before purchasing it
  As a person viewing the site
  I want to view the full details of an item

  Includes:
  - image
  - listing seller (with link to profile)
  - listing ending time
  - current listings show count down with full date. e.g. 4 hours (12/5/2010 8:00 PM)
  - ended listings show only the ending time (either the listing ending time or the moment it was "buy now"'d)
  - opening bid/current bid/final price (as applicable)
  - buy it now price
  - if the listing has ended, who won it
  - listing description
  - size/gender/season/brand/condition information

  Scenario: An listing in general
    Given this listing exists:
      | title      | seller     | brand        | siblings_type | genders | sizes | season | condition | description   | starting_price | buy_now_price |
      | zoot suits | Bob Burger | Janie & Jack | twins         | mm      | 3M    | fall   | new       | Awesome suits | 10.50          | 11.50         |
    When I go to the listing page for "zoot suits"
    Then I should see the heading "zoot suits"
    And I should see "Bob B." within ".seller_name"
    And I should see "Janie & Jack" within ".brand"
    And I should see 2 boys
    # replaces: "mm" within ".child_configuration"
    And I should see "3M" within ".sizes"
    And I should see "fall" within ".seasons"
    And I should see "new" within ".condition"
    And I should see "Awesome suits" within ".description"
    And I should see "$11.50"
    When I click "Bob B."
    Then I should be on the profile page for "Bob Burger"

  Scenario: A Closed Listing
    Given the time is "12/10/2010 13:45 PDT"
    Given these listings exist:
      | title          | started_at       | buy_now_price |
      | 3 sailor suits | 12/03/2010 13:45 | 24.00         |
    And the "3 sailor suits" listing has been bought out by "Janet Jackson"
    When I go to the listing page for "3 sailor suits"
    Then I should not see "Buy Now"
    And I should not see "Bid Now"
    And I should see "Sold On: December 10, 2010 13:45 PST"
    And I should see "$24.00" within ".buy_now_price"
    And I should not see "Janet J."

  Scenario: A finished listing that was "buy now"ed
    Given I am signed in
    And the time is 12/06/2010 13:45 PDT
    And these listings exist:
      | title          | buy_now_price |
      | 3 sailor suits | 25.00         |
    And the time is 12/10/2010 13:45 PST
    And the "3 sailor suits" listing has been bought out by "Janet Jones"
    When I go to the listing page for "3 sailor suits"
    Then I should not see "Buy Now"
    And I should not see "Bid Now"
    And I should see "Sold On: December 10, 2010 13:45 PST"
    And I should see "25.00" within ".buy_now_price"
    And I should not see "Janet J."

  Scenario: An ongoing listing
    Given these listings exist:
      | title      | type           |
      | zoot suits | active_listing |
    When I go to the listing page for "zoot suits"
    Then I should not see "bidder"
    And I should see "Buy Now"