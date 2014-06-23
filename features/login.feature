Feature: Login
  As an admin
  So that I can administer the blog
  I want to login

  Scenario: Visit the log in page
    Given I am on the homepage
    When I click "Log in"
    Then I should be on the login page

  Scenario: Valid log in
    Given I am on the login page
    And I have an account
    When I fill in valid login details
    Then I should be on the homepage
    And I should see notice: "Logged in"

  Scenario: Log in with wrong password
    Given I am on the login page
    And I have an account
    When I fill in the wrong password
    Then I should be on the login page
    And I should see error: "Invalid password!"

  Scenario: Log in with wrong username
    Given I am on the login page
    When I fill in the wrong email
    Then I should be on the login page
    And I should see error: "User doesn't exist"
