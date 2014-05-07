@pending
Feature: User previews listing
  In order to know what my listing is going to look like before it goes live
  As a seller
  I want to preview my listing

  - After filling in the listing form, the user clicks "Preview my listing" (which replaces the "Start Listing" button)
  - User sees listing listing with
  - "Please review your listing - you cannot make edits after clicking START AUCTION" notice at the top
  - edit button that allows them to edit the listing
  - "Start Listing" button that starts the listing


  - User cannot edit an listing once it has started
  - Listing does not show up in listing pages until it has been started

  Background:
    Given there is a child configuration of "triplets" "mmm"
    And there is a child configuration of "triplets" "mmf"
    And there is a child configuration of "siblings" "mf"
    And there is a "new" condition
    And there is a "gently used" condition
    And there is a "Spring" season
    And there is a "Summer" season
    And there is a size "3T"
    And there is a size "5"
    And there is a "full outfits" clothing type
    And there is a "Janie & Jack" brand
    And the time is 10/17/2010 15:45 UTC

  Scenario: Approving the listing after preview
    Given I am signed in as "Sue Smith"
    When I click "Sell"
    Then I should be on the new listing page
    When I fill in "Title" with "3 boys sailor suits"
    And I fill in "Price" with "48.00"
    And I fill in "Shipping/Handling" with "6.66"
    And I check "triplets - mmm"
    And I select "new" from "Condition"
    And I check "Spring"
    And I check "3T"
    And I select "Janie & Jack" from "Brand"
    And I select "full outfits" from "Clothing type"
    And I fill in "Description" with "Three Brand New Janie & Jack boys sailor suits in size 3T"
    And I attach "photo" "jpg" to the "listing"
    And I click "Preview my listing"
    Then I should be on the listing page for "3 boys sailor suits"
    And I should see "Please review your listing - you cannot make edits after clicking START AUCTION"
    When I click "START AUCTION"
    Then I should be on the listing page for "3 boys sailor suits"
    When I go to the listings page
    Then I should see "3 boys sailor suits"

  Scenario: Editting the listing after preview
    Given I am signed in as "Sue Smith"
    And "Sue Smith" has a child configuration of mmm triplets
    When I click "Sell"
    Then I should be on the new listing page
    When I fill in "Title" with "3 boys sailor suits"
    And I fill in "Price" with "48.00"
    And I fill in "Shipping/Handling" with "6.66"
    And I check "triplets - mmm"
    And I select "new" from "Condition"
    And I check "Spring"
    And I check "3T"
    And I select "Janie & Jack" from "Brand"
    And I select "full outfits" from "Clothing type"
    And I fill in "Description" with "Three Brand New Janie & Jack boys sailor suits in size 3T"
    And I attach "photo" "jpg" to the "listing"
    And I click "Preview my listing"
    Then I should be on the listing page for "3 boys sailor suits"
    When I click "EDIT"
    Then I should be on the listing edit page for "3 boys sailor suits"
    When I fill in "Title" with "3 boys sailor suits"
    And I check "5"
    And I click "Preview my listing"
    Then I should be on the listing page for "3 boys sailor suits"
    And I should see "5" within ".sizes"
    When I click "START AUCTION"
    Then I should be on the listing page for "3 boys sailor suits"
    And I should see "5" within ".sizes"

  Scenario: Canceling the listing after preview
    Given I am signed in as "Sue Smith"
    And "Sue Smith" has a child configuration of mmm triplets
    When I click "Sell"
    Then I should be on the new listing page
    When I fill in "Title" with "3 boys sailor suits"
    And I fill in "Price" with "48.00"
    And I fill in "Shipping/Handling" with "6.66"
    And I check "triplets - mmm"
    And I select "new" from "Condition"
    And I check "Spring"
    And I check "3T"
    And I select "Janie & Jack" from "Brand"
    And I select "full outfits" from "Clothing type"
    And I fill in "Description" with "Three Brand New Janie & Jack boys sailor suits in size 3T"
    And I attach "photo" "jpg" to the "listing"
    And I click "Preview my listing"
    And I click "cancel"
    Then I should be on the listings page
    And I should not see "3 boys sailor suits"

  Scenario: Pending listings don't show up on listings page
    Given I am signed in as "Sue Smith"
    And "Sue Smith" has a child configuration of mmm triplets
    When I click "Sell"
    Then I should be on the new listing page
    When I fill in "Title" with "3 boys sailor suits"
    And I fill in "Price" with "48.00"
    And I fill in "Shipping/Handling" with "6.66"
    And I check "triplets - mmm"
    And I select "new" from "Condition"
    And I check "Spring"
    And I check "3T"
    And I select "Janie & Jack" from "Brand"
    And I select "full outfits" from "Clothing type"
    And I fill in "Description" with "Three Brand New Janie & Jack boys sailor suits in size 3T"
    And I attach "photo" "jpg" to the "listing"
    And I click "Preview my listing"
    Given I am signed out
    And I am signed in as "Bobby Bobson"
    When I go to the listings page
    Then I should not see "3 boys sailor suits"