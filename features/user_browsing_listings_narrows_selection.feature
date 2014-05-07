@pending
Feature: Signed out user browses current listings
  In order to see only items appropriate for my current needs
  As a signed in or signed out user
  I want to limit my searching/browsing to certain criteria

includes options to limit by:
- search term
- condition
- size (only sizes we have items for are shown, displayed in numerical order with baby sizes first)
- season
- type (pants, tops, etc.)
- brand (alphabetical order)
The page URL reflects the current view (e.g. it's linkable)

  Background:
    Given there is a "Janie & Jack" brand
    And there is a "Baby GAP" brand
    And there is an "other" brand
    And there is a "3T" size
    And there is a "2T" size
    And there is a "2M" size
    And these listings exist:
      | title | condition   | sizes | brand        | clothing_type      | season |
      | a     | new         | 2T    | Baby GAP     | pants              | spring |
      | b     | new         | 3T    | Janie & Jack | pants              | spring |
      | c     | gently used | 2T    | Baby GAP     | tops               | fall   |
      | d     | gently used | 3T    | other        | tops               | fall   |
      | e     | new         | 2T    | Baby GAP     | outerwear          | winter |
      | f     | gently used | 2M    | other        | outerwear          | fall   |
      | g     | new         | 2T    | Janie & Jack | outerwear          | summer |

  Scenario Outline: Limit by search term
    Given I am signed in as a mother with ffff quads
    When I click "Buy"
    And I click "quads"
    When I click "ffff" within ".left_column"
    # ^-- the default listings are built for ffff quads
    And I <scope_narrowing_action1>
    And I <scope_narrowing_action2>
    And I click "search"
    Then I should see the following listings: "<listings_matching>"
    And I should not see the following listings: "<listings_not_matching>"
    When I copy the page url and open it in a new browser
    Then I should see the following listings: "<listings_matching>"
    And I should not see the following listings: "<listings_not_matching>"

    Examples:
      | scope_narrowing_action1                    | scope_narrowing_action2 | listings_matching | listings_not_matching |
      | select "new" from "Item condition"         | -                       | a, b, e, g        | c, d, f               |
      | select "gently used" from "Item condition" | -                       | c, d, f           | a, b, e, g            |
      | select "new" from "Item condition"         | check "2T"              | a, e, g           | b,c,d,f               |
      | check "Baby GAP"                           | -                       | a, c, e           | b, d, f               |
      | check "Baby GAP"                           | check "Janie & Jack"    | a, b, c, e        | d, f                  |
      | check "2T"                                 | -                       | a, c, e, g        | b, d, f               |
      | check "2T"                                 | check "3T"              | a, b, c, d, e, g  | f                     |
      | check "outerwear"                          | -                       | e, f, g           | a, b, c, d            |
      | check "outerwear"                          | check "tops"            | c, d, e, f, g     | a, b                  |
      | check "spring"                             | -                       | a, b              | c, d, e, f, g         |
      | check "spring"                             | check "summer"          | a, b, g           | c, d, e, f            |
      | check "2T"                                 | check "outerwear"       | e, g              | a, b, c, d, f         |

  Scenario: No results
    Given I am signed in as a mother with ffff quads
    And I click "Buy"
    And I click "quads"
    When I click "ffff" within ".left_column"
    And I fill in "notgoingtohaveresults" for "Search term"
    And I click "search" within ".left_column"
    Then I should not see the following listings: "a, b, c, d, e, f, g"
    And I should see "No listings found"

  Scenario: Limit by size shows only sizes with items available in this search (size visibility)
    Given I am signed in as a mother with ffff quads
    When I click "Buy"
    Then I should see "2T" within "#listing_search_clothing_sizes_input"
    Then I should see "2M" within "#listing_search_clothing_sizes_input"
    Then I should see "3T" within "#listing_search_clothing_sizes_input"
    When I check "Baby GAP"
    And I click "search"
    Then I should see "2T" within "#listing_search_clothing_sizes_input"
    Then I should not see "2M" within "#listing_search_clothing_sizes_input"
    Then I should see "3T" within "#listing_search_clothing_sizes_input"