Feature: Login
  As an admin
  So that I can update the blog
  I want to login

  Scenario: Visit the log in page
    Given I am on the homepage
    When I click "Log in"
    Then I should be on the login page

  Scenario: Valid log in
    Given I am on the login page
    When I fill in valid login details
    And I click "Log in"
    Then I should be on the homepage
    And I should see "Logged in"
