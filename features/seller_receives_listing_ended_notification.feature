@pending
Feature: Seller receives listing ended notification
  In order to know what happened to an listing
  As a seller
  I want to receive an email with the final status of my listing

  - Includes sold/not sold status
  - Includes a link to the listing

  Background:
    Given I have one user "jmacduff@example.com" named "Juno MacDuff"
    And I have one user "plainjane@example.com" named "Jane Doe"
    And these listing exist:
      | title      | description         | starting_price | seller   | shipping_and_handling |
      | zoot suits | three darling suits | 12.00          | Jane Doe | 6.66                  |
    And no emails have been sent

  Scenario: Seller receives notification of successful listing
    When the "zoot suits" listing is bought out by "Juno MacDuff"
    Then "plainjane@example.com" should receive 1 email
    And they open the email
    And they should see "Your Savings Multiplied listing was successful" in the email subject
    And they should see "zoot suits" in the email body
    And they should see "Juno M." in the email body
    And they should see "for $13.00" in the email body
    And they should see "Juno has just received a Paypal payment request, including a $6.66 shipping charge, and you'll receive a Paypal notification once the payment is sent. This is your cue to ship the item(s) as soon as possible." in the email body
    And they should see "If you have any questions, simply reply to this email." in the email body
    And they should see "Thanks for using Savings Multiplied and congratulations on your sale!" in the email body
    When I follow "zoot suits" in the email
    Then I should be on the listing page for "zoot suits"