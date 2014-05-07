@pending
Feature: Items have unique shipping/handling costs
  *When listing an item, I enter my estimated shipping cost
  *Shipping/handling cost is displayed on listings (see attached)
  *Shipping cost is added to total of listing when buyer receives payment notification email/request (right now $5 is added to listing total as a flat rate)
  *Total listing/shipping amount is paid via paypal

  Scenario: Setting S/H when creating an listing
    Given there is a child configuration of "triplets" "mmm"
    And there is a "new" condition
    And there is a "Spring" season
    And there is a size "3T"
    And there is a "full outfits" clothing type
    And there is a "Janie & Jack" brand
    And the time is 10/17/2010 15:45 UTC
    And I am signed in as "Sue Smith"
    When I click "Sell"
    Then I should be on the new listing page
    When I fill in "Title" with "3 boys sailor suits"
    And I fill in "Price" with "48.00"
    And I fill in "Shipping/Handling" with "7.77"
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
    And in the listing listing I should see "Shipping/Handling: $7.77"

  Scenario: Listing ending emails reflect total with S/H
    Given I have one user "jmacduff@example.com" named "Juno MacDuff"
    And these listing exist:
      | title      | description         | buy_now_price | seller   | shipping_and_handling |
      | zoot suits | three darling suits | 12.00         | Jane Doe | 5.55                  |
    And no emails have been sent
    When the "zoot suits" listing is bought out by "Juno MacDuff"
    Then "jmacduff@example.com" should receive 1 email
    When I open the email
    Then I should see "You won the listing" in the email body
    Then "jane_doe@example.com" should receive 1 email
    When I open the email
    Then I should see "5.55" in the email body
    And I should see "12.00" in the email body

  Scenario: Paypal form includes correct S/H
    Given these listings exist:
      | title           | buy_now_price | shipping_and_handling |
      | bg twin clothes | 100           | 15.00                 |
    And the "bg twin clothes" listing has been bought out by "Janet Jackson"
    And I am signed in as "Janet Jackson"
    When I go to the listing page for "bg twin clothes"
    Then I should not see "Winning Bidder"
    And I should see "$100.00"
    And I should see "15.00"