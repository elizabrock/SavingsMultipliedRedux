@pending
Feature: User receives email notification when new items are added
  In order to know that new items have been added to the site that I might be interested in
  As a shopper/registered user
  I want to receive an email notification when items are listed that match my child configuration.

  *When signing up as a user on the site, a checkbox is defaulted as selected saying "Notify me when new items are added in my children's category."
  *When I add an item, an email goes out to everyone who's registered category matches the selected categories for my listing.

  Update: New Item Email is Sent Daily

  Registered members get an email at 2pm CST listing any new items added to the site in their category in the last 24 hours.

  The following items were recently added in your chosen categories:

  listing title (linked)

  listing title (linked)

  etc.

  Click here to view all open listings

  Happy shopping!

  If you no longer wish to receive these notifications, please modify your profile settings

  Background:
    Given there is a "mother" relationship
    And there is an "aunt" relationship
    And there is a page "Terms and Conditions" at "termsandconditions"
    And there is a child configuration of "siblings" "mf"
    And there is a child configuration of "triplets" "mmf"

  Scenario: User sign up defaults to checked
    Given I am not signed in
    When I go to the homepage
    And I click "sign up"
    Then I should be on the sign up page
    And the "Notify me when new items are added in my children's category" checkbox should be checked
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
    When I click "Eliza B."
    And I click "Edit my profile"
    And the "Notify me when new items are added in my children's category" checkbox should be checked

  Scenario: User unchecks email opt-in during sign-up
    Given I am not signed in
    When I go to the homepage
    And I click "sign up"
    And I fill in "First name" with "Eliza"
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
    And I uncheck "Notify me when new items are added in my children's category"
    And I click "Sign up"
    Then I should see "You are now signed up for Savings Multiplied!"
    When I click "Eliza B."
    And I click "Edit my profile"
    And the "Notify me when new items are added in my children's category" checkbox should not be checked

  Scenario: User signed up for emails receives email when appropriate item is posted
    Given I am signed in as "louise@example.com"
    And the time is 10/23/2010 10:12 UTC
    When I go to my edit profile page
    And I select "triplets - mmf" from "darling children"
    And I check "Notify me when new items are added in my children's category"
    And I click "Update My Profile"
    Then I should see "You updated your account successfully."
    When this listing is created:
      | type           | title              | siblings_type | genders |
      | active_listing | boys sailor shorts | triplets      | mmf     |
    And the time is 10/23/2010 19:12 UTC
    And the cron jobs run
    Then "louise@example.com" should receive an email with subject "New items added to Savings Multiplied"
    When I open the email
    Then I should see "The following items were recently added in your chosen categories:" in the email body
    When I follow "boys sailor shorts" in the email
    Then I should be on the listing page for "boys sailor shorts"
    When I follow "modify your profile" in the email
    Then I should be on my edit profile page

  Scenario: User signed up for emails does not receive email when no items are posted
    Given I am signed in as "louise@example.com"
    When I go to my edit profile page
    And I select "triplets - mmf" from "darling children"
    And I check "Notify me when new items are added in my children's category"
    And I click "Update My Profile"
    Then I should see "You updated your account successfully."
    When the cron jobs run
    Then "louise@example.com" should receive no emails

  Scenario: User doesn't receive email for appropriate item that is still in preview state
    Given I am signed in as "louise@example.com"
    When I go to my edit profile page
    And I select "triplets - mmf" from "darling children"
    And I check "Notify me when new items are added in my children's category"
    And I click "Update My Profile"
    Then I should see "You updated your account successfully."
    When this listing is created:
      | type            | title              | siblings_type | genders |
      | preview_listing | boys sailor shorts | triplets      | mmf     |
    And a day passes
    Then "louise@example.com" should receive no emails

  Scenario: User signed up for emails does not receive email when inappropriate item is posted
    Given I am signed in as "louise@example.com"
    When I go to my edit profile page
    And I select "triplets - mmf" from "darling children"
    And I check "Notify me when new items are added in my children's category"
    And I click "Update My Profile"
    Then I should see "You updated your account successfully."
    When a new listing is posted in the mmm triplets category
    And a day passes
    And the cron jobs run
    Then "louise@example.com" should receive no email

  Scenario: User not signed up for emails does not receive email when appropriate item is posted
    Given I am signed in as "louise@example.com"
    When I go to my edit profile page
    And I select "triplets - mmf" from "darling children"
    And I uncheck "Notify me when new items are added in my children's category"
    And I click "Update My Profile"
    Then I should see "You updated your account successfully."
    When a new listing is posted in the mmf triplets category
    And the cron jobs run
    Then "louise@example.com" should receive no email