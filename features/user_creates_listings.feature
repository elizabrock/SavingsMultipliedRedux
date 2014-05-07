@pending
Feature: User lists an listing
  In order to sell my items
  As a signed in user
  I want to list an listing

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

  Scenario: A signed out user
    Given I am not signed in
    When I go to the homepage
    And I click "Sell"
    Then I should see "You must sign in to continue"
    When I fill in the sign in form and submit it
    Then I should be on the new listing page

  Scenario: Creating an listing with good values
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
    And I click "START AUCTION"
    Then I should be on the listing page for "3 boys sailor suits"
    And in the listing listing I should see the uploaded image
    And in the listing listing I should see "new"
    And in the listing listing I should see "Spring"
    And in the listing listing I should see "3T"
    And in the listing listing I should see "Janie & Jack"
    And in the listing listing I should see "Three Brand New Janie & Jack boys sailor suits in size 3T"
    And in the listing listing I should see "Sue S."
    When I click "Sue S."
    Then I should be on the profile page for "Sue Smith"
    And I should see "3 boys sailor suits"

  Scenario Outline: Creating an listing with missing values
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
    When I <action> "<field>"
    And I click "Preview my listing"
    Then I should see the error message "<error message>" on "<field>"

    Examples:
       | action               | field             | error message           |
       | fill in "" for       | Title             | can't be blank          |
       | fill in "" for       | Shipping/Handling | must be greater than 0  |
       | select "" from       | Condition         | can't be blank          |
       | select "" from       | Brand             | can't be blank          |
       | select "" from       | Clothing type     | can't be blank          |
       | fill in "" for       | Description       | can't be blank          |
       | fill in "twelve" for | Price             | must be greater than 0  |
       | fill in "0" for      | Price             | must be greater than 0  |
       | uncheck              | Spring            | must select at least 1. |
       | uncheck              | 3T                | must select at least 1. |

  Scenario: Photo required
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
    And I click "Preview my listing"
    Then I should see the error message "must be set" on "Photo"

  Scenario: Creating an listing with multiple sizes, set types, and seasons
    Given I am signed in as "Sue Smith"
    When I click "Sell"
    And I fill in "Title" with "sibling sailor suits"
    And I fill in "Price" with "48.00"
    And I fill in "Shipping/Handling" with "6.66"
    And I check "siblings - mf"
    And I check "triplets - mmm"
    And I select "gently used" from "Condition"
    And I check "Spring"
    And I check "Summer"
    And I check "3T"
    And I check "5"
    And I select "Janie & Jack" from "Brand"
    And I select "full outfits" from "Clothing type"
    And I fill in "Description" with "Brand New Janie & Jack sailor suits in size 3T and 5.  They fit my kids when they were 3 years old and 6 years old perfectly."
    And I attach "photo" "jpg" to the "listing"
    And I click "Preview my listing"
    Then I should be on the listing page for "sibling sailor suits"
    And in the listing listing I should see the uploaded image
    And in the listing listing I should see "gently used"
    And in the listing listing I should see "Spring"
    And in the listing listing I should see "Summer"
    And in the listing listing I should see "3T"
    And in the listing listing I should see "5"
    And I should see "mmm" icons
    And I should see "mf" icons