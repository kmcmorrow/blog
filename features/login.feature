Feature: Login
  As an admin
  So that I can update the blog
  I want to login

  Scenario: Visit the log in page
    Given I am on the homepage
    When I click "Log in"
    Then I should be on login page
