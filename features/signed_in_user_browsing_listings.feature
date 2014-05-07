@pending
Feature: Signed in user browses current listings
  In order to browse listings that are appropriate to my situation
  As a signed in user
  I want to default to the full view of the listings

  Background:
    Given these listings exist:
      | type           | title                  | siblings_type | genders | description  | brand | seller  |
      | active_listing | bg twin clothes        | twins         | bg      | best         | Gap   | Eliza B |
      | closed_listing | closed bg twin clothes | twins         | bg      | best         | Gap   | Eliza B |
      | active_listing | gg twin clothes        | twins         | gg      | best         | Gap   | Eliza B |
      | active_listing | bbb triplet clothes    | triplets      | bbb     | best         | Gap   | Eliza B |
      | active_listing | banana colored shoes   | twins         | bg      | cherry laces | Gap   | Erin M  |
      | active_listing | strawberry hats        | twins         | bg      | best         | Other | Eliza B |

  Scenario: signed in user defaults to full view
    Given I am signed in as a mother with bg twins
    When I click "Buy"
    Then I should see "All" within ".breadcrumb_nav"
    And I should see the listing "bg twin clothes"
    And I should see the listing "gg twin clothes"
    And I should see the listing "bbb triplet clothes"
    And I should not see the listing "closed bg twin clothes"
    When I copy the page url and open it in a new browser
    And I should see the listing "bg twin clothes"
    And I should see the listing "gg twin clothes"
    And I should see the listing "bbb triplet clothes"
    And I should not see the listing "closed bg twin clothes"

  Scenario: logged in use search form
    Given I am signed in as a mother with bg twins
    When I click "Buy"
    And I click "twins"
    When I click "bg" within ".left_column"
    And I fill in "Search term" with "strawberry"
    And I click "search"
    Then I should see the listing "strawberry hats"
    And I fill in "Search term" with "strawberry hats"
    And I click "search"
    Then I should see the listing "strawberry hats"
    When I fill in "Search term" with "cherry"
    And I click "search"
    Then I should see the listing "banana colored shoes"
    When I fill in "Search term" with "other"
    And I click "search"
    Then I should see the listing "strawberry hats"
    When I fill in "Search term" with "erin"
    And I click "search"
    Then I should see the listing "banana colored shoes"