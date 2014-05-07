@pending
Feature: User receives Q&A notifications

  Background:
    Given no emails have been sent
    And I have one user "jane.doe@example.com" named "Jane Doe"
    And this listing exists:
      | title      | starting_price | seller   |
      | zoot suits | 12.00          | Jane Doe |

  Scenario: Bidder receives notification of answered questions
    Given I am signed in as "unique@email.com"
    And I ask "are they dry clean only?" on "zoot suits"
    And I am signed out
    And I am signed in as "unique2@email.com"
    And I ask "what color are they?" on "zoot suits"
    And I am signed out
    And I am signed in as "jane.doe@example.com"
    And I answer "yes, definitely" for "are they dry clean only?" on "zoot suits"
    Then "unique2@email.com" should receive 1 email
    When I open the email
    Then I should see "Your question about zoot suits has been answered" in the email subject
    And I should see the savings multiplied logo
    And I should see "listing has received a response." in the email body
    And I should see "Please return to the listing to view." in the email body
    When I follow "zoot suits" in the email
    Then I should be on the listing page for "zoot suits"
    Then "unique@email.com" should receive no emails

  Scenario: Seller receives notification of asked questions
    Given I am signed in as "unique@email.com"
    And I ask "are they dry clean only?" on "zoot suits"
    Then "jane.doe@example.com" should receive an email
    When I open the email
    Then I should see "A question has been asked about zoot suits" in the email subject
    And I should see the savings multiplied logo
    And I should see "A question has been posted" in the email body
    When I follow "zoot suits" in the email
    Then I should be on the listing page for "zoot suits"
    When I follow "View it here" in the email
    Then I should be on the listing page for "zoot suits"
    Then "unique@email.com" should receive no emails