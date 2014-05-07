@pending
Feature: Users can leave questions/answers on site listings
  In order to communicate about an listing
  As a buyer or seller
  I want to be able to post comments on the listing

  - Threaded comments
  - Top level comments are displayed as "Questions"
  - Interior comments are displayed as "Answers"

  Scenario: Closed listings don't have Q+A
    Given this listing exists:
      | type           | title      |
      | closed_listing | zoot suits |
    When I go to the listing page for "zoot suits"
    Then I should not see "Ask a question about this listing"

  Scenario: Leaving a Question (buyer)
    Given this listing exists:
      | title      |
      | zoot suits |
    And I am signed in
    When I go to the listing page for "zoot suits"
    Then I should see "Ask a question about this listing"
    When I fill in "Are these tall sized?" for "Question"
    And I press "Post this Question"
    Then I should be on the listing page for "zoot suits"
    And I should see "Are these tall sized?"
    And I should not see "Answer this question"
    And I should see "Ask a question about this listing"

  Scenario: Leaving a Question without content (buyer)
    Given this listing exists:
      | title      |
      | zoot suits |
    And I am signed in
    When I go to the listing page for "zoot suits"
    Then I should see "Ask a question about this listing"
    And I press "Post this Question"
    Then I should see "can't be blank"

  Scenario: Signed out user
    Given this listing exists:
      | title      |
      | zoot suits |
    And I am signed out
    When I go to the listing page for "zoot suits"
    Then I should see "Ask a question about this listing"
    And I should not see "Post this Question"
    And I should see "Please sign in to ask a question."

  Scenario: Answering a Question
    Given I am signed in as "Julie Jones"
    And this listing exists:
      | title      | seller      |
      | zoot suits | Julie Jones |
    And this question exists:
      | listing_title | body                  |
      | zoot suits    | Are these tall sized? |
    When I go to the listing page for "zoot suits"
    Then I should see "Answer this question"
    And I should not see "Ask a question about this listing"
    When I fill in "They are tall sized" for "Answer"
    And I press "Post this Answer"
    Then I should be on the listing page for "zoot suits"
    And I should not see "Answer this question"
    And I should not see "Ask a question about this listing"