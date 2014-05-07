@pending
Feature: User Searches The Site

  Background:
    Given these listings exist:
      | type           | title                  | siblings_type | genders |
      | active_listing | bg twin clothes foo    | twins         | bg      |
      | active_listing | gg twin clothes foo    | twins         | gg      |
      | active_listing | bg twin clothes bar    | twins         | bg      |
      | active_listing | bg sibling clothes foo | sibling sets  | bg      |
      | active_listing | gg sibling clothes foo | sibling sets  | gg      |
      | active_listing | bg sibling clothes bar | sibling sets  | bg      |

  Scenario: Logged In User
    Given I am signed in as a mother with bg twins
    When I fill in "foo" for "listing_search[search_term]"
    And I press "Search"
    Then I should see the listing "bg twin clothes foo"
    And I should see the listing "gg twin clothes foo"
    And I should not see the listing "bg twin clothes bar"
    And I should see the listing "bg sibling clothes foo"
    And I should see the listing "gg sibling clothes foo"
    And I should not see the listing "bg sibling clothes bar"
    When I click "All"
    Then I should see the listing "bg twin clothes foo"
    And I should see the listing "gg twin clothes foo"
    And I should not see the listing "bg twin clothes bar"
    And I should see the listing "bg sibling clothes foo"
    And I should see the listing "gg sibling clothes foo"
    And I should not see the listing "bg sibling clothes bar"
    When I click "sibling set"
    Then I should not see the listing "bg twin clothes foo"
    And I should not see the listing "gg twin clothes foo"
    And I should not see the listing "bg twin clothes bar"
    And I should see the listing "bg sibling clothes foo"
    And I should see the listing "gg sibling clothes foo"
    And I should not see the listing "bg sibling clothes bar"
    And I should not see the listing "bg sibling clothes bar"
    When I click "gg" within ".left_column"
    Then I should not see the listing "bg twin clothes foo"
    And I should not see the listing "gg twin clothes foo"
    And I should not see the listing "bg twin clothes bar"
    And I should not see the listing "bg sibling clothes foo"
    And I should see the listing "gg sibling clothes foo"
    And I should not see the listing "bg sibling clothes bar"

  Scenario: Logged Out User
    Given I am not signed in
    When I fill in "foo" for "listing_search[search_term]"
    And I press "Search"
    Then I should see the listing "bg twin clothes foo"
    And I should see the listing "gg twin clothes foo"
    And I should see the listing "bg sibling clothes foo"
    And I should not see the listing "bg twin clothes bar"
    And I should not see the listing "bg sibling clothes bar"
    When I click "twins" within ".left_column"
    Then I should see the listing "bg twin clothes foo"
    And I should see the listing "gg twin clothes foo"
    And I should not see the listing "bg sibling clothes foo"
    And I should not see the listing "bg twin clothes bar"
    And I should not see the listing "bg sibling clothes bar"
    When click "bg" within ".left_column"
    Then I should see the listing "bg twin clothes foo"
    And I should not see the listing "gg twin clothes foo"
    And I should not see the listing "bg sibling clothes foo"
    And I should not see the listing "bg twin clothes bar"
    And I should not see the listing "bg sibling clothes bar"

  Scenario: Listing with multiple sibling categories is found once
    Given I am not signed in
    And "bg twin clothes foo" is in the "gg twins" category
    When I fill in "foo" for "listing_search[search_term]"
    And I press "Search"
    Then I should see the listing "bg twin clothes foo" only once