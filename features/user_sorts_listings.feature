@pending
Feature: User sorts listings
  In order to find cheap/expensive/similar listings
  As a person browsing the site
  I want to sort the listings

  - Sortable by current bid, title, time-until-expiration
  - Default sort is time-until-expiration with listings ending soonest being shown first
  - Sorting does not change any of the current browsing criteria (e.g. size/type/brand/etc.)
  - The page URL reflects the current view (e.g. it's linkable)

  Background:
    Given there is a "Janie & Jack" brand
    And there is a "Baby GAP" brand
    And there is an "other" brand
    And there is a "3T" size
    And there is a "2T" size
    And there is a "2M" size
    And these listings exist:
      | title | condition   | sizes | brand        | clothing_type | season | buy_now_price | seller   |
      | a     | new         | 2T    | Baby GAP     | pants         | spring | 28            | Jane Doe |
      | b     | new         | 3T    | Janie & Jack | pants         | spring | 30            | Jane Doe |
      | c     | gently used | 2T    | Baby GAP     | tops          | fall   | 25            | Jane Doe |
      | d     | gently used | 3T    | other        | tops          | fall   | 24            | Jane Doe |
      | e     | new         | 2T    | Baby GAP     | outerwear     | winter | 21            | Jane Doe |
      | f     | gently used | 2M    | other        | outerwear     | fall   | 26            | Jane Doe |
      | g     | new         | 2T    | Janie & Jack | outerwear     | summer | 45            | Jane Doe |

  Scenario: Viewing all listings and sorting
    Given I am signed out
    When I click "Buy"
    Then I should not see "Time Left"
    And I select "Price" from "Sort by"
    And I click "Sort"
    Then I should see the following listings: "a, b, c, d, e, f, g" in the order of "e, d, c, f, a, b, g"
    When I copy the page url and open it in a new browser
    Then I should see the following listings: "a, b, c, d, e, f, g" in the order of "e, d, c, f, a, b, g"
    When I select "Title" from "Sort by"
    And I click "Sort"
    Then I should see the following listings: "a, b, c, d, e, f, g" in the order of "a, b, c, d, e, f, g"
    When I copy the page url and open it in a new browser
    Then I should see the following listings: "a, b, c, d, e, f, g" in the order of "a, b, c, d, e, f, g"

  Scenario Outline:
    Given I am signed in as a mother with ffff quads
    When I click "Buy"
    Then I should not see "Time Left"
    And I click "quads"
    When I click "ffff" within ".left_column"
    # ^-- the default listings are built for ffff quads
    And I <scope_narrowing_action1> within ".left_column"
    And I <scope_narrowing_action2> within ".left_column"
    And I click "search"
    When I select "Title" from "Sort by"
    And I click "Sort"
    Then I should see the following listings: "<listings_matching>" in the order of "a, b, c, d, e, f, g"
    When I copy the page url and open it in a new browser
    Then I should see the following listings: "<listings_matching>" in the order of "a, b, c, d, e, f, g"
    And I select "Price" from "Sort by"
    And I click "Sort"
    Then I should see the following listings: "<listings_matching>" in the order of "e, d, c, f, a, b, g"
    When I copy the page url and open it in a new browser
    Then I should see the following listings: "<listings_matching>" in the order of "e, d, c, f, a, b, g"

    Examples:
      | scope_narrowing_action1                    | scope_narrowing_action2 | listings_matching   |
      | -                                          | -                       | a, b, c, d, e, f, g |
      | select "new" from "Item condition"         | -                       | a, b, e, g          |
      | select "gently used" from "Item condition" | -                       | c, d, f             |
      | select "new" from "Item condition"         | check "2T"              | a, e, g             |
      | check "Baby GAP"                           | -                       | a, c, e             |
      | check "Baby GAP"                           | check "Janie & Jack"    | a, b, c, e, g       |
      | check "2T"                                 | -                       | a, c, e, g          |
      | check "2T"                                 | check "3T"              | a, b, c, d, e, g    |
      | check "outerwear"                          | -                       | e, f, g             |
      | check "outerwear"                          | check "tops"            | c, d, e, f, g       |
      | check "spring"                             | -                       | a, b                |
      | check "spring"                             | check "summer"          | a, b, g             |
      | check "2T"                                 | check "outerwear"       | e, g                |