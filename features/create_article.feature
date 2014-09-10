Feature: Create an article
  As an admin
  So that I can share content
  I want to create a new article

  Background:
    Given I am logged in

  Scenario: Visit the new article page
    Given I am on the homepage
    And I click "New Article"
    Then I should be on the new article page

  Scenario: Add a new article
    Given I am on the new article page
    And I add a new article
    Then I should be on the article page
    And I should see the new article

  Scenario: Create an article in a category
    Given there is 1 category
    And I am on the new article page
    And I add a new article in a category
    Then I should be on the article page
    And I should see the article's category

  Scenario: Redirect to login page when not logged in
    Given I am on the homepage
    And I log out
    When I visit the new article page
    Then I should be on the login page

  Scenario Outline: Redirect back to last page when form is cancelled
    Given I am on the <page>
    And I click "New Article"
    When I click "Cancel"
    Then I should be on the <page>
      Examples:
        | page            |
        | homepage        |
        | articles page   |
        | categories page |
