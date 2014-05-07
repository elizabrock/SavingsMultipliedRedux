@pending
Feature: User Signs Up
  In order to place bids or list listings
  As a guest
  I want to sign up

  Background:
    Given there is a "mother" relationship
    And there is an "aunt" relationship
    And there is a page "Terms and Conditions" at "termsandconditions"
    And there is a child configuration of "siblings" "mf"
    And there is a child configuration of "triplets" "mmf"

  Scenario: Happy Path Registration
    Given I am not signed in
    When I go to the homepage
    And I click "sign up"
    Then I should be on the sign up page
    When I fill in "First name" with "Eliza"
    And I fill in "Last name" with "Brock"
    And I fill in "Email" with "eliza@example.com"
    And I check "This is the email I use with PayPal"
    # e.g. I am the aunt of 2 darling children
    And I select "aunt" from "I am the"
    And I select "siblings - mf" from "darling children"
    And I fill in "Password" with "password"
    And I fill in "Password confirmation" with "password"
    #e.g. I check "I accept the terms and conditions"
    And I check "user_terms_accepted"
    And I click "Sign up"
    Then I should see "You are now signed up for Savings Multiplied!"
    And I should see "You are signed in as Eliza B."
    When I click "Eliza B."
    Then I should see the heading "Eliza B."
    And I should see "aunt"
    And I should see 1 boy
    And I should see 1 girl

  Scenario Outline: Registration Errors
    Given I am not signed in
    When I go to the homepage
    And I click "sign up" 
    Then I should be on the sign up page
    When I fill out the sign up form
    And I <action> "<field>"
    And I click "Sign up"
    Then I should see the error message "<error message>"

    Examples:
      | action                       | field                               | error message                              |
      | fill in "" for               | First name                          | First name can't be blank                  |
      | fill in "" for               | Last name                           | Last name can't be blank                   |
      | fill in "" for               | Email                               | Email can't be blank                       |
      | uncheck                      | This is the email I use with PayPal | Email must be the email you use with PayPal  |
      | select "" from               | I am the                            | Relationship to children can't be blank    |
      | fill in "wrong password" for | Password confirmation               | Password doesn't match confirmation        |
      | uncheck                      | user_terms_accepted                 | Terms and Conditions must be accepted      |

  Scenario: Viewing the terms and conditions
    Given I am not signed in
    When I go to the sign up page
    And I click "terms and conditions"
    Then I am on the Terms and Conditions page