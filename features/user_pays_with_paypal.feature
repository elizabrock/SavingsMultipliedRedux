@pending
Feature: User pays with paypal
  In order to pay for my purchase
  As a buyer
  I want to transact with paypal

  - buyer follows link to pay with paypal
  - amount paid includes shipping
  - buyer is returned to the site after paying (exact destination TBD)
  - stores the shipping address as returned by paypal

  Scenario: User pays with paypal
    Given this listing exist:
      | title           | buy_now_price | shipping_and_handling |
      | bg twin clothes | 100           | 15.00                 |
    And the "bg twin clothes" listing has been bought out by "Janet Jackson"
    And I am signed in as "Janet Jackson"
    When I go to the listing page for "bg twin clothes"
    Then I should not see "Winning Bidder"
    When I click "Pay Now" within ".pay_now_form"
    Then I should be on paypal