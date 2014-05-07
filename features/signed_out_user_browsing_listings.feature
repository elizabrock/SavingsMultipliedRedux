@pending
Feature: Signed out user browses current listings
  In order to browse listings that are appropriate to my situation
  As a signed out user
  I want to narrow the view of current listings

  Background:
    Given these listings exist:
      | type           | title                  | siblings_type | genders |
      | active_listing | bg twin clothes        | twins         | bg      |
      | active_listing | bg sibling clothes     | sibling sets  | bg      |
      | closed_listing | closed bg twin clothes | twins         | bg      |
      | active_listing | gg twin clothes        | twins         | gg      |
      | active_listing | bbb triplet clothes    | triplets      | bbb     |
      | active_listing | gbbb triplet clothes   | quads         | gbbb    |

  Scenario: logged out use narrows listing view
    Given I am signed out
    When I click "Buy"
    Then I should see a link "sibling sets"
    And I should see a link "twins"
    And I should see a link "triplets"
    And I should see a link "quads"
    And I should see the listing "bg twin clothes"
    And I should see the listing "gg twin clothes"
    And I should see the listing "bbb triplet clothes"
    And I should not see the listing "closed bg twin clothes"
    When I click "twins"
    Then I should see "twins" within ".breadcrumb_nav"
    And I should see a link "bg"
    # And I should see a link "bb"
    And I should see a link "gg"
    And I should see the listing "bg twin clothes"
    And I should see the listing "gg twin clothes"
    And I should not see the listing "bbb triplet clothes"
    And I should not see the listing "closed bg twin clothes"
    When I click "bg" within ".left_column"
    Then I should see "twins" within ".breadcrumb_nav"
    And I should see "bg" icons within ".breadcrumb_nav"
    And I should see the listing "bg twin clothes"
    And I should not see the listing "gg twin clothes"
    And I should not see the listing "bbb triplet clothes"
    And I should not see the listing "closed bg twin clothes"
    When I copy the page url and open it in a new browser
    Then I should see "twins" within ".breadcrumb_nav"
    And I should see "bg" icons within ".breadcrumb_nav"
    And I should see the listing "bg twin clothes"
    And I should not see the listing "gg twin clothes"
    And I should not see the listing "bbb triplet clothes"
    And I should not see the listing "closed bg twin clothes"